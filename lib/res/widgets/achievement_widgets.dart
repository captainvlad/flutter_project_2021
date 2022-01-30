import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';

class AchievementWidget extends StatelessWidget {
  final double defauktBlurValue = 10;
  final Achievement achievement;

  const AchievementWidget({
    required this.achievement,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      children: [
        UiManager.getText(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: achievement.unlocked ? 0 : defauktBlurValue,
                  sigmaY: achievement.unlocked ? 0 : defauktBlurValue,
                ),
                child: Image.asset(
                  achievement.imagePath,
                ),
              ),
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 6,
            ),
            Column(
              children: <Widget>[
                UiManager.getText(
                  text: achievement.description,
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  strokeColor: whiteColor,
                  fillColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 6,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: more_label,
                    size: uiManager.blockSizeVertical * 2,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    strokeColor: blueColor,
                    fillColor: whiteColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 4,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    if (achievement.unlocked) {
                      Navigator.pushNamed(
                        context,
                        '/detailed_achievement_screen',
                        arguments: achievement,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: locked_achievement,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class AchievementWidgetReversed extends AchievementWidget {
  const AchievementWidgetReversed({
    required Achievement achievement,
    Key? key,
  }) : super(achievement: achievement, key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      children: [
        UiManager.getText(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                UiManager.getText(
                  text: achievement.description,
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  strokeColor: whiteColor,
                  fillColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 6,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: more_label,
                    size: uiManager.blockSizeVertical * 2,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    strokeColor: blueColor,
                    fillColor: whiteColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 4,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    if (achievement.unlocked) {
                      Navigator.pushNamed(
                        context,
                        '/detailed_achievement_screen',
                        arguments: achievement,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: locked_achievement,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                      );
                    }
                  },
                )
              ],
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 6,
            ),
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: achievement.unlocked ? 0 : defauktBlurValue,
                  sigmaY: achievement.unlocked ? 0 : defauktBlurValue,
                ),
                child: Image.asset(
                  achievement.imagePath,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AchievementWidgetFlat extends AchievementWidget {
  const AchievementWidgetFlat({
    required Achievement achievement,
    Key? key,
  }) : super(achievement: achievement, key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      children: [
        UiManager.getText(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiManager.getText(
              text: achievement.description,
              size: uiManager.blockSizeVertical * 2,
              strokeWidth: uiManager.blockSizeVertical * 0,
              strokeColor: whiteColor,
              fillColor: whiteColor,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 4,
            ),
            UiManager.getButton(
              label: UiManager.getText(
                text: more_label,
                size: uiManager.blockSizeVertical * 2,
                strokeWidth: uiManager.blockSizeVertical * 1,
                strokeColor: blueColor,
                fillColor: whiteColor,
              ),
              width: uiManager.blockSizeHorizontal * 25,
              height: uiManager.blockSizeVertical * 4,
              color: yellowColor,
              cornerRaidus: 10,
              onTap: () {
                if (achievement.unlocked) {
                  Navigator.pushNamed(
                    context,
                    '/detailed_achievement_screen',
                    arguments: achievement,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: locked_achievement,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                  );
                }
              },
            )
          ],
        ),
        ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: achievement.unlocked ? 0 : defauktBlurValue,
              sigmaY: achievement.unlocked ? 0 : defauktBlurValue,
            ),
            child: Image.asset(
              achievement.imagePath,
            ),
          ),
        ),
      ],
    );
  }
}
