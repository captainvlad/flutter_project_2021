import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/card_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool screenInitialized = false;
    UiManager uiManager = UiManager(context);
    SettingsBloc _sBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (!screenInitialized) {
          screenInitialized = true;
          _sBloc.add(SettingsEvent.update);
          return const SizedBox.shrink();
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
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
                CustomTextWidget(
                  text: sound,
                  size: uiManager.blockSizeHorizontal * 8,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: state.soundValue.toString(),
                    size: uiManager.blockSizeHorizontal * 6,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                  ),
                  width: uiManager.blockSizeHorizontal * 30,
                  height: uiManager.blockSizeVertical * 5,
                  onTap: () {
                    _sBloc.add(SettingsEvent.toggleSound);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomTextWidget(
                  text: time_limit,
                  size: uiManager.blockSizeHorizontal * 8,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: "${state.defaultTimeValue} min",
                    size: uiManager.blockSizeHorizontal * 6,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                  ),
                  width: uiManager.blockSizeHorizontal * 30,
                  height: uiManager.blockSizeVertical * 5,
                  onTap: () {
                    _sBloc.add(SettingsEvent.toggleTime);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomTextWidget(
                  text: downloaded_questions,
                  size: uiManager.blockSizeHorizontal * 8,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                CustomCardWidget(
                  label: CustomTextWidget(
                    text: "${state.downloadedQuestions}",
                    size: uiManager.blockSizeHorizontal * 6,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                  ),
                  width: uiManager.blockSizeHorizontal * 30,
                  height: uiManager.blockSizeVertical * 5,
                ),
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
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: downloadQuestions,
                    size: uiManager.blockSizeHorizontal * 4,
                    strokeWidth: uiManager.blockSizeHorizontal * 2,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    NavigationManager.navigatorKey.currentState!
                        .pushNamed("/download_questions_screen");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
