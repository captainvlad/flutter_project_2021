import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class Screen18 extends StatelessWidget {
  const Screen18({Key? key}) : super(key: key);

  Widget buildLoadingBody(UiManager uiManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: uiManager.blockSizeVertical * 10,
        ),
        UiManager.getText(
          text: title,
          size: uiManager.blockSizeVertical * 6,
          strokeWidth: uiManager.blockSizeVertical * 1,
          strokeColor: yellowColor,
          fillColor: whiteColor,
        ),
        SizedBox(
          width: double.infinity,
          height: uiManager.blockSizeVertical * 15,
        ),
        UiManager.getText(
          text: good_luck,
          size: uiManager.blockSizeVertical * 4,
          strokeWidth: uiManager.blockSizeVertical * 1,
          strokeColor: yellowColor,
          fillColor: whiteColor,
        ),
        SizedBox(
          width: double.infinity,
          height: uiManager.blockSizeVertical * 10,
        ),
        CircularProgressIndicator(
          color: yellowColor,
          strokeWidth: uiManager.blockSizeVertical * 1,
        ),
      ],
    );
  }

  Widget buildEndScreen(
    UiManager uiManager,
    QuizState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiManager.getText(
              text: correct_total_answers,
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            ),
            UiManager.getCard(
              label: UiManager.getText(
                text: "${state.rightAnswers}/${state.questions.length}",
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 1,
                fillColor: whiteColor,
                strokeColor: blueColor,
              ),
              width: uiManager.blockSizeHorizontal * 40,
              height: uiManager.blockSizeVertical * 5,
              color: yellowColor,
              cornerRaidus: 10,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiManager.getText(
              text: accuracy,
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 15,
            ),
            UiManager.getCard(
              label: UiManager.getText(
                text: "${(state.rightAnswers / state.questions.length) * 100}%",
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 1,
                fillColor: whiteColor,
                strokeColor: blueColor,
              ),
              width: uiManager.blockSizeHorizontal * 40,
              height: uiManager.blockSizeVertical * 5,
              color: yellowColor,
              cornerRaidus: 10,
            ),
          ],
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 3.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiManager.getText(
              text: total_time,
              size: uiManager.blockSizeVertical * 3,
              strokeWidth: uiManager.blockSizeVertical * 0,
              fillColor: whiteColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 10,
            ),
            UiManager.getCard(
              label: UiManager.getText(
                text: "2 min",
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 1,
                fillColor: whiteColor,
                strokeColor: blueColor,
              ),
              width: uiManager.blockSizeHorizontal * 40,
              height: uiManager.blockSizeVertical * 5,
              color: yellowColor,
              cornerRaidus: 10,
            ),
          ],
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 6,
        ),
        UiManager.getText(
          text: well_done,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 30,
        ),
        UiManager.getButton(
          label: UiManager.getText(
            text: got_it,
            size: uiManager.blockSizeVertical * 3,
            strokeWidth: uiManager.blockSizeVertical * 1,
            fillColor: whiteColor,
            strokeColor: blueColor,
          ),
          width: uiManager.blockSizeHorizontal * 40,
          height: uiManager.blockSizeVertical * 5,
          color: yellowColor,
          cornerRaidus: 10,
          onTap: () {
            Navigator.pushNamed(context, '/screen_01');
          },
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
      ],
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
            onTap: () {
              if (_cqBloc.givenAnswer.isEmpty) {
                _cqBloc.givenAnswer = state.currentQuestion.variants[0];
                _cqBloc.add(QuizEvent.checkQuestion);
              }
            }),
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
            onTap: () {
              if (_cqBloc.givenAnswer.isEmpty) {
                _cqBloc.givenAnswer = state.currentQuestion.variants[1];
                _cqBloc.add(QuizEvent.checkQuestion);
              }
            }),
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
            onTap: () {
              if (_cqBloc.givenAnswer.isEmpty) {
                _cqBloc.givenAnswer = state.currentQuestion.variants[2];
                _cqBloc.add(QuizEvent.checkQuestion);
              }
            }),
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
            onTap: () {
              if (_cqBloc.givenAnswer.isEmpty) {
                _cqBloc.givenAnswer = state.currentQuestion.variants[3];
                _cqBloc.add(QuizEvent.checkQuestion);
              }
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ClassicQuizBloc _cqBloc = BlocProvider.of<ClassicQuizBloc>(context);
    GameConfigBloc _gmBloc = BlocProvider.of<GameConfigBloc>(context);
    UiManager uiManager = UiManager(context);

    _cqBloc.quizType = _gmBloc.state.gameMode;
    _cqBloc.quizLevel = _gmBloc.state.level;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ClassicQuizBloc, QuizState>(
          builder: (context, state) {
            if (state.questionIndex == -1) {
              return buildEndScreen(uiManager, state, context);
            } else if (state.questions.isEmpty) {
              _cqBloc.add(QuizEvent.prepare);
              return buildLoadingBody(uiManager);
            } else if (_cqBloc.givenAnswer == 'checked') {
              _cqBloc.givenAnswer = "";
              _cqBloc.add(QuizEvent.next);
              return buildLoadingBody(uiManager);
            } else {
              return buildQuestionBody(uiManager, state, _cqBloc);
            }
          },
        ),
      ),
    );
  }
}
