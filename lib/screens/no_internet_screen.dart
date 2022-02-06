import 'package:flutter/material.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

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
              width: double.infinity,
            ),
            CustomTextWidget(
              text: oops,
              size: uiManager.blockSizeVertical * 6,
              strokeWidth: uiManager.blockSizeVertical * 1,
              fillColor: yellowColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 4,
            ),
            CustomTextWidget(
              text: no_internet_message,
              size: uiManager.blockSizeVertical * 3,
            ),
            Image.asset(
              'assets/images/image_22.png',
              height: uiManager.blockSizeVertical * 30,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 4,
            ),
            CustomTextWidget(
              text: no_internet_description,
              size: uiManager.blockSizeVertical * 3,
            ),
            CustomButtonWidget(
              label: CustomTextWidget(
                text: play_offline,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 1,
              ),
              width: uiManager.blockSizeHorizontal * 80,
              height: uiManager.blockSizeVertical * 6,
              onTap: () {
                NavigationManager.popToFirst();
              },
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            CustomButtonWidget(
              label: CustomTextWidget(
                text: quit,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 1,
              ),
              width: uiManager.blockSizeHorizontal * 80,
              height: uiManager.blockSizeVertical * 6,
              onTap: () {
                UtilityManager().quitApp();
              },
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
          ],
        ),
      ),
    );
  }
}
