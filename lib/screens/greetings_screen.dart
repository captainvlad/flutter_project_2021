import 'package:flutter/material.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String title;

    if (arguments.containsKey("text")) {
      title = arguments["text"];
    } else {
      title = good_luck;
    }

    UiManager uiManager = UiManager(context);

    return WillPopScope(
      onWillPop: () async {
        return await UtilityManager().popCallback();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: uiManager.blockSizeVertical * 10,
              ),
              Center(
                child: CustomTextWidget(
                  text: title,
                  size: uiManager.blockSizeVertical * 6,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  strokeColor: yellowColor,
                  fillColor: whiteColor,
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 5,
              ),
              CustomButtonWidget(
                label: CustomTextWidget(
                  text: back_to_app,
                  size: uiManager.blockSizeVertical * 2.5,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 8,
                onTap: () async {
                  await UtilityManager().popCallback();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
