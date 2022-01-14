import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class GreetingsScreen extends StatelessWidget {
  final String title;

  const GreetingsScreen({
    this.title = good_luck,
    Key? key,
  }) : super(key: key);

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
              height: uiManager.blockSizeVertical * 10,
            ),
            Center(
              child: UiManager.getText(
                text: title,
                size: uiManager.blockSizeVertical * 6,
                strokeWidth: uiManager.blockSizeVertical * 1,
                strokeColor: yellowColor,
                fillColor: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
