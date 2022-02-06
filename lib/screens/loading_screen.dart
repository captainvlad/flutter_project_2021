import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
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
          Stack(
            children: [
              SizedBox(
                width: uiManager.blockSizeHorizontal * 15,
                height: uiManager.blockSizeHorizontal * 15,
                child: CircularProgressIndicator(
                  color: whiteColor,
                  strokeWidth: uiManager.blockSizeVertical / 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  uiManager.blockSizeHorizontal * 1,
                  uiManager.blockSizeHorizontal * 1,
                  0.0,
                  0.0,
                ),
                child: SizedBox(
                  width: uiManager.blockSizeHorizontal * 13,
                  height: uiManager.blockSizeHorizontal * 13,
                  child: CircularProgressIndicator(
                    color: yellowColor,
                    strokeWidth: uiManager.blockSizeVertical,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  uiManager.blockSizeHorizontal * 2,
                  uiManager.blockSizeHorizontal * 2,
                  0.0,
                  0.0,
                ),
                child: SizedBox(
                  width: uiManager.blockSizeHorizontal * 11,
                  height: uiManager.blockSizeHorizontal * 11,
                  child: CircularProgressIndicator(
                    color: whiteColor,
                    strokeWidth: uiManager.blockSizeVertical / 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
