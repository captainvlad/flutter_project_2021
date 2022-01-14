import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';

import 'classic_quiz_bloc.dart';

class BulletQuizBloc extends Bloc<QuizEvent, QuizState> {
  late String quizType;
  late String quizLevel;

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
        break;
      case QuizStatus.nextQuestion:
        state.nextQuestion();
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

  Map<String, dynamic> getStatistics() {
    String accuracy;

    if (state.questionIndex == 0) {
      accuracy = "0.0%";
    } else {
      accuracy = "${state.rightAnswers / state.questionIndex * 100}%";
    }

    return {
      "correct_answers": "${state.rightAnswers}",
      "all_answers": "${state.questionIndex}",
      "accuracy": accuracy,
    };
  }
}
