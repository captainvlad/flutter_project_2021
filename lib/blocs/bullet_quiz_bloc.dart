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

import 'classic_quiz_bloc.dart';

class BulletQuizBloc extends Bloc<QuizEvent, QuizState> {
  late String quizType;
  late String quizLevel;
  late DateTime dateTimeStart;

  BulletQuizBloc() : super(QuizState());

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
