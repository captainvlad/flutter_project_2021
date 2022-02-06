import 'package:flutter/material.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/colors.dart';

class CustomProgressSpinner extends StatelessWidget {
  final UiManager uiManager;

  const CustomProgressSpinner({Key? key, required this.uiManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
