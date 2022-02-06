import 'package:flutter/material.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/achievement_widgets.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    List<Achievement> achievements = arguments["achievements"];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidget(
                achievement: achievements[0],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              AchievementWidgetReversed(
                achievement: achievements[1],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidget(
                achievement: achievements[2],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidgetReversed(
                achievement: achievements[3],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidget(
                achievement: achievements[4],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidgetReversed(
                achievement: achievements[5],
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              AchievementWidgetFlat(
                achievement: achievements[6],
              )
            ],
          ),
        ),
      ),
    );
  }
}
