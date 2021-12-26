import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/strings.dart';

class Screen04 extends StatelessWidget {
  const Screen04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsBloc _sBloc = BlocProvider.of<SettingsBloc>(context);
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
              width: double.infinity,
            ),
            UiManager.getText(
              text: title,
              size: uiManager.blockSizeVertical * 6,
              strokeWidth: uiManager.blockSizeVertical * 1,
              fillColor: yellowColor,
              strokeColor: whiteColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 4,
              width: double.infinity,
            ),
            UiManager.getText(
              text: sound,
              size: uiManager.blockSizeHorizontal * 8,
              strokeWidth: uiManager.blockSizeHorizontal * 0,
              fillColor: whiteColor,
              strokeColor: blueColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
              return UiManager.getButton(
                label: UiManager.getText(
                  text: state.soundValue.toString(),
                  size: uiManager.blockSizeHorizontal * 6,
                  strokeWidth: uiManager.blockSizeHorizontal * 2,
                  fillColor: whiteColor,
                  strokeColor: blueColor,
                ),
                width: uiManager.blockSizeHorizontal * 30,
                height: uiManager.blockSizeVertical * 5,
                color: yellowColor,
                cornerRaidus: 10,
                onTap: () {
                  _sBloc.add(SettingsEvent.toggleSound);
                },
              );
            }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getText(
              text: time_limit,
              size: uiManager.blockSizeHorizontal * 8,
              strokeWidth: uiManager.blockSizeHorizontal * 0,
              fillColor: whiteColor,
              strokeColor: blueColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
              return UiManager.getButton(
                label: UiManager.getText(
                  text: "${state.defaultTimeValue} min",
                  size: uiManager.blockSizeHorizontal * 6,
                  strokeWidth: uiManager.blockSizeHorizontal * 2,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 30,
                height: uiManager.blockSizeVertical * 5,
                color: yellowColor,
                cornerRaidus: 10,
                onTap: () {
                  _sBloc.add(SettingsEvent.toggleTime);
                },
              );
            }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            UiManager.getText(
              text: downloaded_questions,
              size: uiManager.blockSizeHorizontal * 8,
              strokeWidth: uiManager.blockSizeHorizontal * 0,
              fillColor: whiteColor,
              strokeColor: blueColor,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
              String displayValue = state.downloadedQuestions == -1
                  ? ""
                  : "${state.downloadedQuestions}";

              if (state.downloadedQuestions == -1) {
                _sBloc.add(SettingsEvent.updateDownloadedQuestions);
              }

              return UiManager.getCard(
                label: UiManager.getText(
                  text: displayValue,
                  size: uiManager.blockSizeHorizontal * 6,
                  strokeWidth: uiManager.blockSizeHorizontal * 2,
                  strokeColor: blueColor,
                  fillColor: whiteColor,
                ),
                width: uiManager.blockSizeHorizontal * 30,
                height: uiManager.blockSizeVertical * 5,
                color: yellowColor,
                cornerRaidus: 10,
              );
            }),
            SizedBox(
              height: uiManager.blockSizeVertical * 2,
            ),
            Image.asset(
              'assets/images/image_6.png',
              width: uiManager.blockSizeHorizontal * 80,
            ),
            SizedBox(
              height: uiManager.blockSizeVertical * 6,
            ),
            UiManager.getButton(
              label: UiManager.getText(
                text: downloadQuestions,
                size: uiManager.blockSizeHorizontal * 4,
                strokeWidth: uiManager.blockSizeHorizontal * 2,
                strokeColor: blueColor,
                fillColor: whiteColor,
              ),
              width: uiManager.blockSizeHorizontal * 60,
              height: uiManager.blockSizeVertical * 6,
              color: yellowColor,
              cornerRaidus: 10,
              onTap: () {
                Navigator.pushNamed(context, '/screen_11');
              },
            ),
          ],
        ),
      ),
    );
  }
}
