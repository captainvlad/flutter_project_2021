import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class AchievementWidget extends StatelessWidget {
  final double defauktBlurValue = 10;
  final Achievement achievement;

  const AchievementWidget({
    required this.achievement,
    Key? key,
  }) : super(key: key);

  void onMoreTapped() {
    if (achievement.unlocked) {
      NavigationManager.navigatorKey.currentState!.pushNamed(
        '/detailed_achievement_screen',
        arguments: achievement,
      );
    } else {
      UtilityManager().showToast(toastText: locked_achievement);
    }
  }

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      children: [
        CustomTextWidget(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
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
                CustomTextWidget(
                  text: achievement.description,
                  size: uiManager.blockSizeVertical * 2,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 6,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: more_label,
                    size: uiManager.blockSizeVertical * 2,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 4,
                  onTap: () => onMoreTapped(),
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
        CustomTextWidget(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomTextWidget(
                  text: achievement.description,
                  size: uiManager.blockSizeVertical * 2,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 6,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: more_label,
                    size: uiManager.blockSizeVertical * 2,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 4,
                  onTap: () => onMoreTapped(),
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
        CustomTextWidget(
          text: achievement.name,
          size: uiManager.blockSizeVertical * 3,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget(
              text: achievement.description,
              size: uiManager.blockSizeVertical * 2,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 4,
            ),
            CustomButtonWidget(
              label: CustomTextWidget(
                text: more_label,
                size: uiManager.blockSizeVertical * 2,
                strokeWidth: uiManager.blockSizeVertical * 1,
              ),
              width: uiManager.blockSizeHorizontal * 25,
              height: uiManager.blockSizeVertical * 4,
              onTap: () => onMoreTapped(),
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
