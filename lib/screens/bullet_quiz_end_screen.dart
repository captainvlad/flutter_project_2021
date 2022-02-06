import 'package:flutter/material.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/stats_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/card_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class BulletQuizEndScreen extends StatelessWidget {
  const BulletQuizEndScreen({Key? key}) : super(key: key);

  Future<bool> _popCallback(
    BuildContext context,
    Map<dynamic, dynamic> arguments,
  ) async {
    NavigationManager.popScreen();
    String accuracyValue = arguments["accuracy"].replaceAll('%', '');

    await StatsManager().updateBulletStatistics(
      Statistic(
        totalGamesPlayed: 1,
        avgAccuracyClassic: 0,
        achievementsNumber: 0,
        downloadedQuestions: 0,
        totalGamesPlayedBullet: 0,
        totalGamesPlayedClassic: 0,
        totalPlayTime: arguments["play_time_min"],
        avgAccuracyBullet: double.parse(accuracyValue).toInt(),
        downloadedUsedQuestions: int.parse(arguments["all_answers"]),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    UiManager uiManager = UiManager(context);

    return WillPopScope(
      onWillPop: () async {
        return await _popCallback(context, arguments);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: total_answers,
                    size: uiManager.blockSizeVertical * 3,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 18,
                  ),
                  CustomCardWidget(
                    label: CustomTextWidget(
                      text: arguments["all_answers"],
                      size: uiManager.blockSizeVertical * 3,
                      strokeWidth: uiManager.blockSizeVertical * 1,
                    ),
                    width: uiManager.blockSizeHorizontal * 40,
                    height: uiManager.blockSizeVertical * 5,
                  ),
                ],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: right_answers,
                    size: uiManager.blockSizeVertical * 3,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 28,
                  ),
                  CustomCardWidget(
                    label: CustomTextWidget(
                      text: arguments["correct_answers"],
                      size: uiManager.blockSizeVertical * 3,
                      strokeWidth: uiManager.blockSizeVertical * 1,
                    ),
                    width: uiManager.blockSizeHorizontal * 40,
                    height: uiManager.blockSizeVertical * 5,
                  ),
                ],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: accuracy,
                    size: uiManager.blockSizeVertical * 3,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 15,
                  ),
                  CustomCardWidget(
                    label: CustomTextWidget(
                      text: arguments["accuracy"],
                      size: uiManager.blockSizeVertical * 3,
                      strokeWidth: uiManager.blockSizeVertical * 1,
                    ),
                    width: uiManager.blockSizeHorizontal * 40,
                    height: uiManager.blockSizeVertical * 5,
                  ),
                ],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 6,
              ),
              CustomTextWidget(
                text: well_done,
                size: uiManager.blockSizeVertical * 3,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 30,
              ),
              CustomButtonWidget(
                label: CustomTextWidget(
                  text: got_it,
                  size: uiManager.blockSizeVertical * 3,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                ),
                width: uiManager.blockSizeHorizontal * 40,
                height: uiManager.blockSizeVertical * 5,
                onTap: () async {
                  await _popCallback(context, arguments);
                },
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
