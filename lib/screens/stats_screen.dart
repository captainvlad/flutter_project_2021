import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/statistics_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatisticsBloc _stBloc = BlocProvider.of<StatisticsBloc>(context);
    UiManager uiManager = UiManager(context);
    bool screenInitialized = false;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (!screenInitialized) {
              _stBloc.add(StatisticsEvent.update);
              screenInitialized = true;
              return SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                  width: double.infinity,
                ),
                UiManager.getText(
                  text: title,
                  size: uiManager.blockSizeVertical * 6,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  fillColor: yellowColor,
                  strokeColor: whiteColor,
                ),
                Image.asset(
                  'assets/images/image_2.png',
                  width: uiManager.blockSizeVertical * 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: play_time,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 8,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.totalPlayedMinutes}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: games_played,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 3,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.totalGamesPlayed}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: average_accuracy_classic,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 6,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.averageAccuracyCla}%",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: average_accuracy_bullet,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 6,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.averageAccuracyBul}%",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: achievements,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 10,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text:
                            "${state.achievementsNumber}/${AchievementsManager.standardAchievements.length}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 3,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: all_achievements,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () async {
                    List<Achievement> la =
                        await AchievementsManager().getAchievementsCasted();

                    Navigator.pushNamed(
                      context,
                      '/achievements_screen',
                      arguments: {
                        'achievements': la,
                      },
                    );
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: reset,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () async {
                    // AAADIP remove to utilities then
                    print("RESET BUTTON PRESSED");
                    _stBloc.add(StatisticsEvent.reset);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: update,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () {
                    _stBloc.add(StatisticsEvent.update);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
