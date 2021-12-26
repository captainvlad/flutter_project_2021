import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/levels.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/questions_types.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/questions_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';

enum QuizEvent {
  prepare,
  next,
  checkQuestion,
}

class QuizState extends Equatable {
  late int version;
  late List<Question> questions;
  late Question currentQuestion;
  late int questionIndex;
  late int rightAnswers;
  List<Color> answerColors = [
    yellowColor,
    yellowColor,
    yellowColor,
    yellowColor
  ];

  QuestionsManager questionApiManager = QuestionsManager();
  QuestionsCacheManager questionDbManager = QuestionsCacheManager();
  int questionsNumber = 20;

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
  String givenAnswer = "";

  ClassicQuizBloc() : super(QuizState());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    switch (event) {
      case QuizEvent.prepare:
        await state.loadQuestionsFromDb(quizType);

        break;
      case QuizEvent.next:
        if (state.questionIndex == state.questions.length - 1) {
          yield QuizState(
            questions: state.questions,
            questionIndex: -1,
            rightAnswers: state.rightAnswers,
            currentQuestion: state.questions[state.questionIndex],
          );
        } else {
          state.nextQuestion();
        }

        break;
      case QuizEvent.checkQuestion:
        state.checkQuestion(givenAnswer);

        QuizState result = QuizState(
          questions: state.questions,
          questionIndex: state.questionIndex,
          rightAnswers: state.rightAnswers,
          currentQuestion: state.questions[state.questionIndex],
        );

        result.answerColors = state.answerColors;
        yield result;

        await Future.delayed(const Duration(seconds: 2));
        givenAnswer = "checked";

        break;
    }

    yield QuizState(
      questions: state.questions,
      questionIndex: state.questionIndex,
      rightAnswers: state.rightAnswers,
      currentQuestion: state.questions[state.questionIndex],
    );
  }
}
