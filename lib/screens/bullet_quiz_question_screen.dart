import 'package:flutter/material.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/colors.dart';

import 'bullet_quiz_timer.dart';

class BulletQuizQuestionScreen extends StatelessWidget {
  const BulletQuizQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    TimerWidget tw = TimerWidget(
      duration: 10,
      onExpired: () {
        NavigationManager.navigatorKey.currentState!.pushNamed(
          '/screen_11',
          arguments: {"a": "ab"},
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: uiManager.blockSizeVertical * 4,
            ),
            const Text(
              "HIHIHIHIT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 4,
            ),
            Container(
              color: Colors.teal,
              child: tw,
            )
          ],
        ),
      ),
    );
  }
}
