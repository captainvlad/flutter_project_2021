import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class ClassicQuizQuestionScreen extends StatelessWidget {
  const ClassicQuizQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClassicQuizBloc _cqBloc = BlocProvider.of<ClassicQuizBloc>(context);
    GameConfigBloc _gmBloc = BlocProvider.of<GameConfigBloc>(context);

    _cqBloc.quizType = _gmBloc.state.gameMode;
    _cqBloc.quizLevel = _gmBloc.state.level;

    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ClassicQuizBloc, QuizState>(
          builder: (context, state) {
            if (state.questions.isEmpty) {
              loadQuestions(_cqBloc);
              return const SizedBox.shrink();
            }

            return buildQuestionBody(uiManager, state, _cqBloc);
          },
        ),
      ),
    );
  }

  void checkQuestion(
    String answer,
    ClassicQuizBloc _cqBloc,
    QuizState state,
  ) {
    bool questionIsUnChecked = state.answerColors.every(
      (element) => element == yellowColor,
    );

    if (questionIsUnChecked) {
      _cqBloc.add(
        QuizEvent(
          status: QuizStatus.checkQuestion,
          arguments: {"answer": answer},
        ),
      );

      _cqBloc.add(
        const QuizEvent(status: QuizStatus.nextQuestion),
      );
    }
  }

  void loadQuestions(
    ClassicQuizBloc _cqBloc,
  ) {
    _cqBloc.add(
      const QuizEvent(status: QuizStatus.loadQuestions),
    );
  }

  Widget buildQuestionBody(
    UiManager uiManager,
    QuizState state,
    ClassicQuizBloc _cqBloc,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: uiManager.blockSizeVertical * 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiManager.getText(
              text: question_1,
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 10,
            ),
            UiManager.getText(
              text: "#${state.questionIndex + 1}/${state.questions.length}",
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            )
          ],
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 3,
        ),
        Image.asset(
          'assets/images/image_30.png',
          width: uiManager.blockSizeHorizontal * 80,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 3,
        ),
        SizedBox(
          width: uiManager.blockSizeHorizontal * 75,
          child: UiManager.getText(
            text: biggestBoxOfficeTitle,
            size: uiManager.blockSizeVertical * 3,
            strokeWidth: uiManager.blockSizeVertical * 0,
            strokeColor: yellowColor,
            fillColor: whiteColor,
          ),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 3,
        ),
        UiManager.getButton(
          label: UiManager.getText(
            text: state.currentQuestion.variants[0],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
            strokeColor: blueColor,
            fillColor: whiteColor,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[0],
          cornerRaidus: 10,
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[0], _cqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        UiManager.getButton(
          label: UiManager.getText(
            text: state.currentQuestion.variants[1],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
            strokeColor: blueColor,
            fillColor: whiteColor,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[1],
          cornerRaidus: 10,
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[1], _cqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        UiManager.getButton(
          label: UiManager.getText(
            text: state.currentQuestion.variants[2],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
            strokeColor: blueColor,
            fillColor: whiteColor,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[2],
          cornerRaidus: 10,
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[2], _cqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        UiManager.getButton(
          label: UiManager.getText(
            text: state.currentQuestion.variants[3],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
            strokeColor: blueColor,
            fillColor: whiteColor,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[3],
          cornerRaidus: 10,
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[3], _cqBloc, state),
        ),
      ],
    );
  }
}
