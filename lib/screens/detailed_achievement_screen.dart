import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class DetailedAchievementScreen extends StatelessWidget {
  const DetailedAchievementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Achievement;
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
                width: double.infinity,
              ),
              CustomTextWidget(
                text: title,
                size: uiManager.blockSizeVertical * 6,
                strokeWidth: uiManager.blockSizeVertical * 1,
                fillColor: yellowColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              CustomTextWidget(
                text: argument.name,
                size: uiManager.blockSizeVertical * 3,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Image.asset(
                argument.imagePath,
                width: uiManager.blockSizeHorizontal * 75,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              CustomTextWidget(
                text: argument.description,
                size: uiManager.blockSizeVertical * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
