import 'package:flutter/material.dart';
import 'package:sequel/blocs/stats_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/card_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  Future allAchievementsTapped() async {
    List<Achievement> achievements =
        await AchievementsManager().getAchievementsCasted();

    NavigationManager.pushNamed(
        '/achievements_screen', {'achievements': achievements});
  }

  @override
  Widget build(BuildContext context) {
    bool screenInitialized = false;
    UiManager uiManager = UiManager(context);
    StatsBloc _stBloc = BlocProvider.of<StatsBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<StatsBloc, StatsState>(
          builder: (context, state) {
            if (!screenInitialized) {
              screenInitialized = true;
              _stBloc.add(StatsEvent.update);
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                  width: double.infinity,
                ),
                CustomTextWidget(
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
                    CustomTextWidget(
                      text: play_time,
                      size: uiManager.blockSizeHorizontal * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 8,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.totalPlayedMinutes}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: games_played,
                      size: uiManager.blockSizeHorizontal * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 3,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.totalGamesPlayed}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: average_accuracy_classic,
                      size: uiManager.blockSizeHorizontal * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 6,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.averageAccuracyCla}%",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: average_accuracy_bullet,
                      size: uiManager.blockSizeHorizontal * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 6,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.averageAccuracyBul}%",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: achievements,
                      size: uiManager.blockSizeHorizontal * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeVertical * 10,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text:
                            "${state.achievementsNumber}/${AchievementsManager.standardAchievements.length}",
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      width: uiManager.blockSizeHorizontal * 35,
                      height: uiManager.blockSizeVertical * 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 3,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: all_achievements,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () async {
                    await allAchievementsTapped();
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: reset,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () async {
                    _stBloc.add(StatsEvent.reset);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: update,
                    size: uiManager.blockSizeHorizontal * 5,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 80,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    _stBloc.add(StatsEvent.update);
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
