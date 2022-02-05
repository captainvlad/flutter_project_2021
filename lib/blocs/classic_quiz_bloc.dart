import 'package:flutter/rendering.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/questions_manager.dart';
import 'package:sequel/general_models/questions_types.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum QuizStatus {
  loadQuestions,
  nextQuestion,
  checkQuestion,
}

class QuizEvent {
  final QuizStatus status;
  final Map<String, dynamic> arguments;

  const QuizEvent({
    required this.status,
    this.arguments = const {},
  });
}

class QuizState extends Equatable {
  late int version;
  late List<Question> questions;
  late Question currentQuestion;
  late int questionIndex;
  late int rightAnswers;
  late List<Color> answerColors = [
    yellowColor,
    yellowColor,
    yellowColor,
    yellowColor
  ];

  final QuestionsCacheManager questionDbManager = QuestionsCacheManager();
  final QuestionsManager questionApiManager = QuestionsManager();
  final int questionsNumber = 20;

  QuizState({
    this.version = 0,
    this.questions = const [],
    this.questionIndex = 0,
    this.rightAnswers = 0,
    this.currentQuestion = const Question(),
  });

  @override
  List<Object?> get props => [
        version,
        questions,
        questionIndex,
        answerColors,
      ];

  QuestionType quizTypeToQuestionType(String quizType) {
    switch (quizType) {
      case button_6:
        return QuestionType.oldestFilmQuestion;
      case button_6_1:
        return QuestionType.filmByImageQuestion;
      case button_6_2:
        return QuestionType.directorByPosterQuestion;
      case button_6_3:
        return QuestionType.filmByTagline;
      case button_6_4:
        return QuestionType.oddFilmQuestion;
    }

    return QuestionType.topRatingQuestion;
  }

  Future loadQuestionsFromApi(String type, String level) async {
    version++;
    questions = [];

    try {
      for (int i = 0; i < questionsNumber; i++) {
        Question q = await questionApiManager.getQuestion(
          quizTypeToQuestionType(type),
          level,
        );
        questions.add(q);
      }
    } catch (e) {
      print("Connection problems, gonna try get from local db");
      loadQuestionsFromDb(type);
    }
  }

  Future<bool> loadQuestionsFromDb(String type) async {
    version++;
    questions = [];

    try {
      questions = await questionDbManager.getAllQuestions();
      questions = questions.sublist(0, questionsNumber);
      return true;
    } catch (e) {
      print("Database problems, we cannot continue working");
      NavigationManager.navigatorKey.currentState!.pushNamed(
        "/greetings_screen",
        arguments: {"text": "Sorry, no questions available. Download some"},
      );
      return false;
    }
  }

  void nextQuestion() {
    version++;
    questionIndex++;
    currentQuestion = questions[questionIndex];
  }

  void checkQuestion(String givenAnswer) {
    version++;

    for (int i = 0; i < currentQuestion.variants.length; i++) {
      String variant = currentQuestion.variants[i];

      if (givenAnswer == variant &&
          givenAnswer == currentQuestion.rightAnswer) {
        answerColors[i] = greenColor;
        rightAnswers++;
        break;
      } else if (givenAnswer == variant) {
        answerColors[i] = redColor;
      } else if (variant == currentQuestion.rightAnswer &&
          variant != givenAnswer) {
        answerColors[i] = greenColor;
      }
    }
  }
}

class ClassicQuizBloc extends Bloc<QuizEvent, QuizState> {
  late String quizType;
  late String quizLevel;
  late DateTime dateTimeStart;

  ClassicQuizBloc() : super(QuizState());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    switch (event.status) {
      case QuizStatus.loadQuestions:
        NavigationManager.navigatorKey.currentState!
            .pushNamed("/loading_screen");

        bool result = await state.loadQuestionsFromDb(quizType);

        if (!result) {
          break;
        }

        await Future.delayed(const Duration(seconds: 5));

        NavigationManager.navigatorKey.currentState!.pop();
        dateTimeStart = DateTime.now();
        break;
      case QuizStatus.nextQuestion:
        if (state.questionIndex == state.questions.length - 1) {
          int minutesSpent = DateTime.now().difference(dateTimeStart).inMinutes;
          NavigationManager.navigatorKey.currentState!.pop();
          NavigationManager.navigatorKey.currentState!.pop();

          bool hardLevelOn = quizLevel == "Hard";
          Map<String, dynamic> classicStats = getStatistics(
            minutesSpent,
          );

          List<String> unlockedAchievements =
              await checkForUnlockedAchievementsClassic(
            hardLevelOn,
            false,
            classicStats,
          );

          classicStats["unlocked_achievements"] = unlockedAchievements;
          String unlockedAchievementsMessage =
              generateMessage(unlockedAchievements);

          if (unlockedAchievementsMessage.isNotEmpty) {
            Fluttertoast.showToast(
              msg: unlockedAchievementsMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }

          NavigationManager.navigatorKey.currentState!.pushNamed(
            '/classic_end_screen',
            arguments: classicStats,
          );
          return;
        } else {
          state.nextQuestion();
        }

        break;
      case QuizStatus.checkQuestion:
        QuizState result = QuizState(
          questions: state.questions,
          questionIndex: state.questionIndex,
          rightAnswers: state.rightAnswers,
          currentQuestion: state.currentQuestion,
        );

        result.checkQuestion(event.arguments["answer"]);
        yield result;
      // await Future.delayed(const Duration(seconds: 1));
    }

    yield QuizState(
      questions: state.questions,
      questionIndex: state.questionIndex,
      rightAnswers: state.rightAnswers,
      currentQuestion: state.questions[state.questionIndex],
    );
  }

  // AAADIP remove to Achievements manager
  Future<List<String>> checkForUnlockedAchievementsClassic(
    bool hardLevel,
    bool multiPlayerOn,
    Map<String, dynamic> bulletStats,
  ) async {
    List<String> result = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

// Gordon Gekko unlocking
    bool allAnswersCorrect =
        bulletStats["accuracy"] == "100.0%"; // Should be in classic mode!

    bool allAnswersWrong = bulletStats["accuracy"] == "0.0%" &&
        int.parse(bulletStats["all_answers"]) > 0; // Should be in classic mode!

    if (allAnswersCorrect) {
      int? winningStreak = pref.getInt("winning_strike");

      if (winningStreak == null) {
        pref.setInt("winning_strike", 1);
      } else if (winningStreak < 2) {
        pref.setInt("winning_strike", winningStreak + 1);
      } else {
        Achievement unlockedAchievement =
            await AchievementsManager().getAchievementByName(gordon_gekko);

        if (!unlockedAchievement.unlocked) {
          result.add(unlockedAchievement.name);
          AchievementsManager().unlockItem(unlockedAchievement, 1);
        }
      }
    } else {
      pref.setInt("winning_strike", 0);
    }

// Flash unlocking  AAADIP SHOULD BE IN CLASSIC MODE!
    if (int.parse(bulletStats["total_time"][0]) < 2) {
      // Fix this later!
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(flash);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Alan Turing unlocking
    if (allAnswersCorrect && hardLevel) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(alan_turing);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// The Dude unlocking
    if (multiPlayerOn) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(the_dude);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// 'Ace' and Nicky unlocking
    if (allAnswersWrong) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(ace_nicky);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Badcomedian unlocking
    int achievementsUnlocked = 0;
    List<Achievement> achi = await AchievementsManager()
        .getAchievementsCasted(); // Make new method for getting unlocked achievements

    for (Achievement a in achi) {
      if (a.unlocked) {
        achievementsUnlocked++;
      }
    }

    if (achievementsUnlocked >= 6) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(badcomedian);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

    return result;
  }

  Map<String, dynamic> getStatistics(
    int minutesSpent,
  ) {
    String accuracy;

    if (state.questionIndex == 0) {
      accuracy = "0.0%";
    } else {
      accuracy =
          "${(state.rightAnswers / (state.questionIndex + 1) * 100).toStringAsFixed(1)}%";
    }

    return {
      "correct_answers": "${state.rightAnswers}",
      "all_answers": "${state.questionIndex + 1}",
      "accuracy": accuracy,
      "total_time": "$minutesSpent min",
    };
  }

  // AAADIP remove to utilities manager
  String generateMessage(List<String> achievementsNames) {
    if (achievementsNames.isEmpty) {
      return "";
    } else if (achievementsNames.length == 1) {
      return "Following achievement: ${achievementsNames[0]} was unlocked";
    }

    String result = "Following achievements: " +
        achievementsNames.join(", ") +
        " were unclocked";

    return result;
  }
}
