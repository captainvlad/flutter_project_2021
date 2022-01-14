import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameConfigBloc _gmBloc = BlocProvider.of<GameConfigBloc>(context);
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GameConfigBloc, GameConfigState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                  height: uiManager.blockSizeVertical * 8,
                ),
                UiManager.getText(
                  text: game_type,
                  size: uiManager.blockSizeVertical * 4,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: state.gameType,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 5,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleGameType);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getText(
                  text: game_mode,
                  size: uiManager.blockSizeVertical * 4,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: state.gameMode,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 10,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleGameMode);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getText(
                  text: level,
                  size: uiManager.blockSizeVertical * 4,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: state.level,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleLevel);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getText(
                  text: multiplayer,
                  size: uiManager.blockSizeVertical * 4,
                  strokeWidth: uiManager.blockSizeVertical * 0,
                  fillColor: whiteColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: state.multiplayer,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleMultiplayer);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 12,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_9,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    fillColor: whiteColor,
                    strokeColor: blueColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    if (_gmBloc.state.multiplayer == button_8_1) {
                      Navigator.pushNamed(
                          context, '/under_construction_screen');
                    } else if (_gmBloc.state.gameType == button_5) {
                      Navigator.pushNamed(
                          context, '/bullet_quiz_question_screen');
                    } else {
                      Navigator.pushNamed(
                        context,
                        '/classic_quiz_question_screen',
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
