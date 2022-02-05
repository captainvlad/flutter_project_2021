import 'package:flutter/material.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/strings.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({
    Key? key,
  }) : super(key: key);

  Future<bool> _popCallback() {
    NavigationManager.navigatorKey.currentState!
        .popUntil((route) => route.isFirst);

    return Future(() => true);
  }

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
        return await _popCallback();
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
                child: UiManager.getText(
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
              UiManager.getButton(
                label: UiManager.getText(
                  text: "Back to app",
                  size: uiManager.blockSizeVertical * 2.5,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  fillColor: whiteColor,
                  strokeColor: blueColor,
                ),
                width: uiManager.blockSizeHorizontal * 60,
                height: uiManager.blockSizeVertical * 8,
                color: yellowColor,
                cornerRaidus: 10.0,
                onTap: () {
                  NavigationManager.navigatorKey.currentState!
                      .popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
