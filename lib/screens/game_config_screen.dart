import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class GameConfigScreen extends StatelessWidget {
  const GameConfigScreen({Key? key}) : super(key: key);

  void startGameTransition(GameConfigBloc _gmBloc) {
    if (_gmBloc.state.multiplayer == on) {
      NavigationManager.navigatorKey.currentState!
          .pushNamed('/under_construction_screen');
    } else if (_gmBloc.state.gameType == bullet) {
      NavigationManager.navigatorKey.currentState!
          .pushNamed('/bullet_quiz_question_screen');
    } else {
      NavigationManager.navigatorKey.currentState!
          .pushNamed('/classic_quiz_question_screen');
    }
  }

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
                CustomTextWidget(
                  text: title,
                  size: uiManager.blockSizeVertical * 6,
                  strokeWidth: uiManager.blockSizeVertical * 1,
                  fillColor: yellowColor,
                  strokeColor: whiteColor,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 8,
                ),
                CustomTextWidget(
                  text: game_type,
                  size: uiManager.blockSizeVertical * 4,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: state.gameType,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 5,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleGameType);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomTextWidget(
                  text: game_mode,
                  size: uiManager.blockSizeVertical * 4,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: state.gameMode,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 10,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleGameMode);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomTextWidget(
                  text: level,
                  size: uiManager.blockSizeVertical * 4,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: state.level,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleLevel);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomTextWidget(
                  text: multiplayer,
                  size: uiManager.blockSizeVertical * 4,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 1,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: state.multiplayer,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    _gmBloc.add(GameConfigEvent.toggleMultiplayer);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 12,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: go,
                    size: uiManager.blockSizeHorizontal * 7,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    startGameTransition(_gmBloc);
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
