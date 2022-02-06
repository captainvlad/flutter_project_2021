import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: uiManager.blockSizeVertical * 5,
            ),
            CustomTextWidget(
              text: title,
              size: uiManager.blockSizeVertical * 6,
              strokeWidth: uiManager.blockSizeVertical * 1,
              strokeColor: yellowColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 20,
            ),
            CustomTextWidget(
              text: construction_message,
              size: uiManager.blockSizeVertical * 4,
              strokeWidth: uiManager.blockSizeVertical * 1,
              strokeColor: yellowColor,
            ),
          ],
        ),
      ),
    );
  }
}
