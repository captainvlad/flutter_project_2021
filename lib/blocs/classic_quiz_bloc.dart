import 'package:flutter/rendering.dart';
import 'package:equatable/equatable.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/questions_manager.dart';
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

  Future loadQuestionsFromDb(String type) async {
    version++;
    questions = [];

    try {
      questions = await questionDbManager.getAllQuestions();
      questions = questions.sublist(0, questionsNumber);
    } catch (e) {
      print("Database problems, we cannot continue working");
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

        await state.loadQuestionsFromDb(quizType);
        await Future.delayed(const Duration(seconds: 5));

        NavigationManager.navigatorKey.currentState!.pop();
        dateTimeStart = DateTime.now();
        break;
      case QuizStatus.nextQuestion:
        if (state.questionIndex == state.questions.length - 1) {
          int minutesSpent = DateTime.now().difference(dateTimeStart).inMinutes;
          NavigationManager.navigatorKey.currentState!.pop();
          NavigationManager.navigatorKey.currentState!.pop();

          NavigationManager.navigatorKey.currentState!.pushNamed(
            '/classic_end_screen',
            arguments: {
              "correct_answers": state.rightAnswers,
              "all_answers": state.questions.length,
              "accuracy":
                  "${state.rightAnswers / state.questions.length * 100}%",
              "total_time": "$minutesSpent min",
            },
          );
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
        await Future.delayed(const Duration(seconds: 1));
    }

    yield QuizState(
      questions: state.questions,
      questionIndex: state.questionIndex,
      rightAnswers: state.rightAnswers,
      currentQuestion: state.questions[state.questionIndex],
    );
  }
}
