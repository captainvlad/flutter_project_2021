import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 28,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: uiManager.blockSizeVertical * 2,
                    ),
                    CustomTextWidget(
                      text: about_app,
                      size: uiManager.blockSizeHorizontal * 7,
                      strokeWidth: uiManager.blockSizeHorizontal * 2,
                    ),
                    SizedBox(
                      height: uiManager.blockSizeVertical * 2,
                    ),
                    CustomTextWidget(
                      text: app_description,
                      size: uiManager.blockSizeHorizontal * 4,
                      strokeWidth: uiManager.blockSizeHorizontal * 2,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_5.png',
                width: uiManager.blockSizeHorizontal * 80,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 32,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_types,
                        size: uiManager.blockSizeHorizontal * 7,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_types_description,
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_7.png',
                width: uiManager.blockSizeHorizontal * 80,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 72,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_modes,
                        size: uiManager.blockSizeHorizontal * 7,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_modes_description,
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_8.png',
                width: uiManager.blockSizeHorizontal * 80,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 29,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_levels,
                        size: uiManager.blockSizeHorizontal * 7,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: game_levels_description,
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_9.png',
                width: uiManager.blockSizeHorizontal * 80,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 21,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: multiplayer,
                        size: uiManager.blockSizeHorizontal * 7,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: multiplayer_description,
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_10.png',
                width: uiManager.blockSizeHorizontal * 80,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Container(
                width: uiManager.blockSizeHorizontal * 80,
                height: uiManager.blockSizeVertical * 26,
                decoration: const BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: offline_mode,
                        size: uiManager.blockSizeHorizontal * 7,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 2,
                      ),
                      CustomTextWidget(
                        text: offline_mode_description,
                        size: uiManager.blockSizeHorizontal * 4,
                        strokeWidth: uiManager.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
              ),
              Image.asset(
                'assets/images/image_11.png',
                width: uiManager.blockSizeHorizontal * 80,
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
