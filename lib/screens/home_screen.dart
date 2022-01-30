import 'package:flutter/material.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/res/icons/images.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getText(
              text: title,
              size: uiManager.blockSizeVertical * 6,
              strokeWidth: uiManager.blockSizeVertical * 1,
              fillColor: yellowColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            Image.asset(
              'assets/images/image_1.png',
              width: uiManager.blockSizeHorizontal * 90,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_1,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () async {
                    for (int i = 0; i < 20; i++) {
                      await QuestionsCacheManager().cacheItem(const Question(
                        title: 'TITLE',
                        imagePath: biggestBoxOfficeQuestionImage,
                        rightAnswer: 'RIGHT',
                        variants: ['RIGHT', 'WRONG', 'WRONG', 'WRONG'],
                      ));
                    }

                    Navigator.pushNamed(context, '/game_config_screen');
                  },
                ),
                SizedBox(
                  width: uiManager.blockSizeVertical * 2,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_2,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () async {
                    Navigator.pushNamed(context, '/stats_screen');
                  },
                ),
              ],
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_3,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () {
                    Navigator.pushNamed(context, '/setting_screen');
                  },
                ),
                SizedBox(
                  width: uiManager.blockSizeVertical * 2,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_4,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10.0,
                  onTap: () {
                    Navigator.pushNamed(context, '/about_app_screen');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
