import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/managers/ui_manager.dart';

class Screen15 extends StatelessWidget {
  const Screen15({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: uiManager.blockSizeVertical * 2,
          width: double.infinity,
        ),
        UiManager.getText(
          text: "Loading",
          size: uiManager.blockSizeVertical * 4,
          strokeWidth: uiManager.blockSizeVertical * 1,
          fillColor: yellowColor,
          strokeColor: whiteColor,
        ),
        SizedBox(
          height: uiManager.blockSizeVertical * 20,
        ),
        CircularProgressIndicator(
          color: yellowColor,
          strokeWidth: uiManager.blockSizeVertical * 1,
        ),
      ],
    );
  }
}
