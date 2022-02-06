import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/bullet_quiz_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';
import 'package:sequel/res/widgets/timer_widget.dart';

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
    SettingsBloc _stBloc,
    GameConfigBloc _gmBloc,
  ) {
    int playTime = _stBloc.state.defaultTimeValue;

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
            CustomTextWidget(
              text: question_1,
              size: uiManager.blockSizeVertical * 3,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 5,
            ),
            CustomTextWidget(
              text: "#${state.questionIndex + 1}",
              size: uiManager.blockSizeVertical * 3,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 10,
            ),
            TimerWidget(
              duration: playTime * 60,
              onExpired: () async {
                Map<String, dynamic> bulletStats = _bqBloc.getStatistics();
                bool hardLevelOn = _gmBloc.state.level == "Hard";

                bulletStats["play_time_min"] = playTime;

                List<String> unlockedAchievements = await AchievementsManager()
                    .checkForUnlockedAchievementsBullet(
                  hardLevelOn,
                  false,
                  bulletStats,
                );

                bulletStats["unlocked_achievements"] = unlockedAchievements;

                String unlockedAchievementsMessage =
                    UtilityManager().generateMessage(unlockedAchievements);

                if (unlockedAchievementsMessage.isNotEmpty) {
                  UtilityManager()
                      .showToast(toastText: unlockedAchievementsMessage);
                }

                NavigationManager.popScreen(times: 2);
                NavigationManager.pushNamed('/bullet_end_screen', bulletStats);
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
          child: CustomTextWidget(
            text: biggestBoxOfficeTitle,
            size: uiManager.blockSizeVertical * 3,
            strokeColor: yellowColor,
          ),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 3,
        ),
        CustomButtonWidget(
          label: CustomTextWidget(
            text: state.currentQuestion.variants[0],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[0],
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[0], _bqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        CustomButtonWidget(
          label: CustomTextWidget(
            text: state.currentQuestion.variants[1],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[1],
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[1], _bqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        CustomButtonWidget(
          label: CustomTextWidget(
            text: state.currentQuestion.variants[2],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[2],
          onTap: () =>
              checkQuestion(state.currentQuestion.variants[2], _bqBloc, state),
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
        ),
        CustomButtonWidget(
          label: CustomTextWidget(
            text: state.currentQuestion.variants[3],
            size: uiManager.blockSizeVertical * 2,
            strokeWidth: uiManager.blockSizeVertical * 1,
          ),
          width: uiManager.blockSizeHorizontal * 60,
          height: uiManager.blockSizeVertical * 4,
          color: state.answerColors[3],
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
    SettingsBloc _stBloc = BlocProvider.of<SettingsBloc>(context);

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

            return buildQuestionBody(
              uiManager,
              state,
              _bqBloc,
              _stBloc,
              _gmBloc,
            );
          },
        ),
      ),
    );
  }
}
