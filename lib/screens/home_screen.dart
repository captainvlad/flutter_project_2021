import 'package:flutter/material.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

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
            CustomTextWidget(
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
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: play,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    NavigationManager.pushNamed('/game_config_screen', null);
                  },
                ),
                SizedBox(
                  width: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: stats,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    NavigationManager.pushNamed('/stats_screen', null);
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
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: settings,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    NavigationManager.pushNamed('/settings_screen', null);
                  },
                ),
                SizedBox(
                  width: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: about,
                    size: uiManager.blockSizeVertical * 2.5,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 40,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    NavigationManager.pushNamed('/about_app_screen', null);
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
