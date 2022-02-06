import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/progress_spinner_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: uiManager.blockSizeVertical * 2,
            width: double.infinity,
          ),
          CustomTextWidget(
            text: loading,
            size: uiManager.blockSizeVertical * 4,
            strokeWidth: uiManager.blockSizeVertical * 1,
            fillColor: yellowColor,
            strokeColor: whiteColor,
          ),
          SizedBox(
            height: uiManager.blockSizeVertical * 20,
          ),
          CustomProgressSpinner(
            uiManager: uiManager,
          ),
        ],
      ),
    );
  }
}
