import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class Screen14 extends StatelessWidget {
  const Screen14({Key? key}) : super(key: key);

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
              height: uiManager.blockSizeVertical * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiManager.getText(
                  text: question_1,
                  size: uiManager.blockSizeVertical * 3,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  width: uiManager.blockSizeHorizontal * 10,
                ),
                UiManager.getText(
                  text: time_left,
                  size: uiManager.blockSizeVertical * 3,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                )
              ],
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 3,
            ),
            Image.asset(
              'assets/images/image_30.png',
              width: uiManager.blockSizeHorizontal * 80,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 3,
            ),
            SizedBox(
              width: uiManager.blockSizeHorizontal * 75,
              child: UiManager.getText(
                text: biggestBoxOfficeTitle,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                strokeColor: yellowColor,
                fillColor: whiteColor,
              ),
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 3,
            ),
            UiManager.getButton(
                label: UiManager.getText(
                  text: "Godfather",
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 4,
                color: yellowColor,
                cornerRaidus: 10,
                onTap: () {
                  print("Godfather");
                }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getButton(
                label: UiManager.getText(
                  text: "Redemption",
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 4,
                color: yellowColor,
                cornerRaidus: 10,
                onTap: () {
                  print("Redemption");
                }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getButton(
                label: UiManager.getText(
                  text: "Gone in sixty",
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 4,
                color: redColor,
                cornerRaidus: 10,
                onTap: () {
                  print("Gone in sixty");
                }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getButton(
                label: UiManager.getText(
                  text: "The dark knight",
                  size: uiManager.blockSizeVertical * 2,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 4,
                color: greenColor,
                cornerRaidus: 10,
                onTap: () {
                  print("The dark knight");
                }),
          ],
        ),
      ),
    );
  }
}
