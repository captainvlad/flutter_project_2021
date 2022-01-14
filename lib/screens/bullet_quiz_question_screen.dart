import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/bullet_quiz_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';

import 'bullet_quiz_timer.dart';

class BulletQuizQuestionScreen extends StatelessWidget {
  const BulletQuizQuestionScreen({Key? key}) : super(key: key);

  void checkQuestion(
    String answer,
    BulletQuizBloc _bqBloc,
    QuizState state,
  ) {
    bool questionIsUnChecked = state.answerColors.every(
      (element) => element == yellowColor,
    );

    if (questionIsUnChecked) {
      _bqBloc.add(
        QuizEvent(
          status: QuizStatus.checkQuestion,
          arguments: {"answer": answer},
        ),
      );

      _bqBloc.add(
        const QuizEvent(status: QuizStatus.nextQuestion),
      );
    }
  }

  Widget buildQuestionBody(
    UiManager uiManager,
    QuizState state,
    BulletQuizBloc _bqBloc,
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
              width: uiManager.blockSizeHorizontal * 5,
            ),
            UiManager.getText(
              text: "#${state.questionIndex + 1}",
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 10,
            ),
            TimerWidget(
              duration: 10,
              onExpired: () {
                NavigationManager.navigatorKey.currentState!.pop();
                NavigationManager.navigatorKey.currentState!.pop();
                NavigationManager.navigatorKey.currentState!.pushNamed(
                  '/bullet_end_screen',
                  arguments: _bqBloc.getStatistics(),
                );
              },
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
              checkQuestion(state.currentQuestion.variants[0], _bqBloc, state),
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
              checkQuestion(state.currentQuestion.variants[1], _bqBloc, state),
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
              checkQuestion(state.currentQuestion.variants[2], _bqBloc, state),
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
              checkQuestion(state.currentQuestion.variants[3], _bqBloc, state),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BulletQuizBloc _bqBloc = BlocProvider.of<BulletQuizBloc>(context);
    GameConfigBloc _gmBloc = BlocProvider.of<GameConfigBloc>(context);

    _bqBloc.quizType = _gmBloc.state.gameMode;
    _bqBloc.quizLevel = _gmBloc.state.level;

    UiManager uiManager = UiManager(context);

    void loadQuestions(BulletQuizBloc _bqBloc) {
      _bqBloc.add(
        const QuizEvent(status: QuizStatus.loadQuestions),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BulletQuizBloc, QuizState>(
          builder: (context, state) {
            if (state.questions.isEmpty) {
              loadQuestions(_bqBloc);
              return const SizedBox.shrink();
            }

            return buildQuestionBody(uiManager, state, _bqBloc);
          },
        ),
      ),
    );
  }
}
