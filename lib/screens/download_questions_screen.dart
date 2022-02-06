import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/res/widgets/button_widget.dart';
import 'package:sequel/res/widgets/card_widget.dart';
import 'package:sequel/res/widgets/text_widget.dart';

class DownloadQuestionsScreen extends StatelessWidget {
  const DownloadQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool screenInitialized = false;

    DownloadBloc _dBloc = BlocProvider.of<DownloadBloc>(context);
    GameConfigBloc _gcBloc = BlocProvider.of<GameConfigBloc>(context);

    UiManager uiManager = UiManager(context);

    return BlocBuilder<DownloadBloc, DownloadState>(builder: (context, state) {
      if (!screenInitialized) {
        _dBloc.state.setStateGameLevel(_gcBloc.state.level);
        _dBloc.add(DownloadEvent.updateQuestions);
        screenInitialized = true;
        return const SizedBox.shrink();
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  height: uiManager.blockSizeVertical * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: questions_available,
                      size: uiManager.blockSizeVertical * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.questionsAvailable}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: questions_used,
                      size: uiManager.blockSizeVertical * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    CustomCardWidget(
                      label: CustomTextWidget(
                        text: "${state.questionsUsed}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/image_24.png',
                  width: uiManager.blockSizeHorizontal * 80,
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: questions_to_upload,
                      size: uiManager.blockSizeVertical * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    CustomButtonWidget(
                      label: CustomTextWidget(
                        text: "${state.questionsToUpload}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      onTap: () {
                        _dBloc.add(DownloadEvent.changeUploadQuestions);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: remove_previous,
                      size: uiManager.blockSizeVertical * 4,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 8,
                    ),
                    CustomButtonWidget(
                      label: CustomTextWidget(
                        text: state.removePrevious ? "True" : "False",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      onTap: () {
                        _dBloc.add(DownloadEvent.removePreviousQuestions);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 4,
                ),
                CustomButtonWidget(
                  label: CustomTextWidget(
                    text: download,
                    size: uiManager.blockSizeVertical * 3,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  onTap: () {
                    _dBloc.add(DownloadEvent.download);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
