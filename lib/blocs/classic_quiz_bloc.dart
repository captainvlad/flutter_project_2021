import 'package:flutter/rendering.dart';
import 'package:equatable/equatable.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/managers/questions_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/general_models/questions_types.dart';
import 'package:sequel/managers/questions_cache_manager.dart';

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
      case head_to_head:
        return QuestionType.oldestFilmQuestion;
      case guess_by_frame:
        return QuestionType.filmByImageQuestion;
      case guess_director:
        return QuestionType.directorByPosterQuestion;
      case guess_by_tag:
        return QuestionType.filmByTagline;
      case find_the_odd:
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
          NavigationManager.navigatorKey.currentState!
              .pushNamed("/no_questions_screen");
          break;
        }

        await UtilityManager().sleep(seconds: 5);

        NavigationManager.popScreen();
        dateTimeStart = DateTime.now();
        break;
      case QuizStatus.nextQuestion:
        if (state.questionIndex == state.questions.length - 1) {
          DateTime currentTime = DateTime.now();
          Duration minutesSpent = currentTime.difference(dateTimeStart);

          bool hardLevelOn = quizLevel == "Hard";
          NavigationManager.popScreen(times: 2);

          Map<String, dynamic> classicStats = getStatistics(
            minutesSpent.inMinutes,
          );

          List<String> unlockedAchievements =
              await AchievementsManager().checkForUnlockedAchievementsClassic(
            hardLevelOn,
            false,
            classicStats,
          );

          classicStats["unlocked_achievements"] = unlockedAchievements;
          String unlockedAchievementsMessage =
              UtilityManager().generateMessage(unlockedAchievements);

          if (unlockedAchievementsMessage.isNotEmpty) {
            UtilityManager().showToast(toastText: unlockedAchievementsMessage);
          }

          NavigationManager.pushNamed('/classic_end_screen', classicStats);
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
}
