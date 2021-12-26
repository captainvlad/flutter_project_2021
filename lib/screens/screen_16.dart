import 'package:flutter/material.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';

class Screen16 extends StatelessWidget {
  const Screen16({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
          width: double.infinity,
        ),
        UiManager.getText(
          text: oops,
          size: uiManager.blockSizeVertical * 6,
          strokeWidth: uiManager.blockSizeVertical * 1,
          fillColor: yellowColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 4,
        ),
        UiManager.getText(
          text: no_internet_message,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
        Image.asset(
          'assets/images/image_22.png',
          height: uiManager.blockSizeVertical * 30,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 4,
        ),
        UiManager.getText(
          text: no_internet_description,
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        ),
      ],
    );
  }
}
