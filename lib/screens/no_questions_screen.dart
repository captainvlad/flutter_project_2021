import 'package:flutter/material.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class NoQuestionsScreen extends StatelessWidget {
  const NoQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return WillPopScope(
      onWillPop: () async {
        return await UtilityManager().popCallback();
      },
      child: Scaffold(
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
                text: no_questions,
                size: uiManager.blockSizeVertical * 3,
              ),
              Image.asset(
                'assets/images/image_21.png',
                height: uiManager.blockSizeVertical * 30,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              CustomTextWidget(
                text: no_questions_description,
                size: uiManager.blockSizeVertical * 3,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 5,
              ),
              CustomButtonWidget(
                label: CustomTextWidget(
                  text: back,
                  size: uiManager.blockSizeVertical * 3,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                ),
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 6,
                onTap: () async {
                  await UtilityManager().popCallback();
                },
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
