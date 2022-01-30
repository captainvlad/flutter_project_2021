import 'package:flutter/material.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/statistics_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class BulletQuizEndScreen extends StatelessWidget {
  const BulletQuizEndScreen({Key? key}) : super(key: key);

  Future<bool> _popCallback(
    BuildContext context,
    Map<dynamic, dynamic> arguments,
  ) async {
    Navigator.pop(context);
    String accuracyValue = arguments["accuracy"].replaceAll('%', '');

    StatisticsManager().updateBulletStatistics(
      Statistic(
        totalPlayTime: arguments["play_time_min"],
        totalGamesPlayed: 1,
        avgAccuracyBullet: double.parse(accuracyValue).toInt(),
        avgAccuracyClassic: 0,
        achievementsNumber: 0,
        downloadedQuestions: 0,
        downloadedUsedQuestions: int.parse(arguments["all_answers"]),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    UiManager uiManager = UiManager(context);

    print("HERE AAADIP 0");
    print(arguments["unlocked_achievements"]);

    return WillPopScope(
      onWillPop: () => _popCallback(context, arguments),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiManager.getText(
                    text: total_answers,
                    size: uiManager.blockSizeVertical * 3,
                    strokeWidth: uiManager.blockSizeVertical * 0,
                    fillColor: whiteColor,
                    strokeColor: whiteColor,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 18,
                  ),
                  UiManager.getCard(
                    label: UiManager.getText(
                      text: arguments["all_answers"],
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
                    text: right_answers,
                    size: uiManager.blockSizeVertical * 3,
                    strokeWidth: uiManager.blockSizeVertical * 0,
                    fillColor: whiteColor,
                    strokeColor: whiteColor,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 28,
                  ),
                  UiManager.getCard(
                    label: UiManager.getText(
                      text: arguments["correct_answers"],
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
                      text: arguments["accuracy"],
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
                  _popCallback(context, arguments);
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
