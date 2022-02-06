import 'package:flutter/material.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/stats_manager.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/card_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class ClassicQuizEndScreen extends StatelessWidget {
  const ClassicQuizEndScreen({Key? key}) : super(key: key);

  Future<bool> _popCallback(
    Map<dynamic, dynamic> arguments,
  ) async {
    NavigationManager.popScreen(times: 2);

    String playTime = arguments["total_time"].replaceAll(RegExp("[^0-9]"), "");
    String accuracyValue = arguments["accuracy"].replaceAll('%', '');

    await StatsManager().updateClassicStatistics(
      Statistic(
        totalGamesPlayed: 1,
        avgAccuracyBullet: 0,
        achievementsNumber: 0,
        downloadedQuestions: 0,
        totalGamesPlayedBullet: 0,
        totalGamesPlayedClassic: 0,
        totalPlayTime: int.parse(playTime),
        avgAccuracyClassic: double.parse(accuracyValue).toInt(),
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
        return await _popCallback(arguments);
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
                    text: correct_total_answers,
                    size: uiManager.blockSizeVertical * 3,
                  ),
                  CustomCardWidget(
                    label: CustomTextWidget(
                      text:
                          "${arguments["correct_answers"]}/${arguments["all_answers"]}",
                      size: uiManager.blockSizeVertical * 3,
                      strokeWidth: uiManager.blockSizeVertical * 1,
                    ),
                    width: uiManager.blockSizeHorizontal * 40,
                    height: uiManager.blockSizeVertical * 5,
                  ),
                ],
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
                height: uiManager.blockSizeVertical * 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: total_time,
                    size: uiManager.blockSizeVertical * 3,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 10,
                  ),
                  CustomCardWidget(
                    label: CustomTextWidget(
                      text: arguments["total_time"],
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
                  await _popCallback(arguments);
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
