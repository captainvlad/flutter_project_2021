import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sequel/blocs/bullet_quiz_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/statistics_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              // duration: playTime * 60,
              onExpired: () async {
                Map<String, dynamic> bulletStats = _bqBloc.getStatistics();
                bool hardLevelOn = _gmBloc.state.level == "Hard";

                bulletStats["play_time_min"] = playTime;

                List<String> unlockedAchievements =
                    await checkForUnlockedAchievementsBullet(
                  hardLevelOn,
                  false,
                  bulletStats,
                );

                bulletStats["unlocked_achievements"] = unlockedAchievements;

                String unlockedAchievementsMessage =
                    generateMessage(unlockedAchievements);

                if (unlockedAchievementsMessage.isNotEmpty) {
                  Fluttertoast.showToast(
                    msg: unlockedAchievementsMessage,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                  );
                }

                NavigationManager.navigatorKey.currentState!.pop();
                NavigationManager.navigatorKey.currentState!.pop();

                NavigationManager.navigatorKey.currentState!.pushNamed(
                  '/bullet_end_screen',
                  arguments: bulletStats,
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

// AAADIP remove to Achievements manager
  Future<List<String>> checkForUnlockedAchievementsBullet(
    bool hardLevel,
    bool multiPlayerOn,
    Map<String, dynamic> bulletStats,
  ) async {
    List<String> result = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

// Gordon Gekko unlocking
    bool allAnswersCorrect = bulletStats["accuracy"] == "100.0%";

    bool allAnswersWrong = bulletStats["accuracy"] == "0.0%" &&
        int.parse(bulletStats["all_answers"]) > 0;

// Rocky Balboa unlocking
    int? recordStreak = pref.getInt("record_breaking_strike");
    int? previousRecord = pref.getInt("bullet_record");
    int correctAnswers = int.parse(bulletStats["correct_answers"]);

    if (previousRecord == null || recordStreak == null) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", 0);
    } else if (correctAnswers > previousRecord && recordStreak < 2) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", recordStreak + 1);
    } else if (correctAnswers > previousRecord && recordStreak >= 2) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", recordStreak + 1);
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(rocky_balboa);

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
