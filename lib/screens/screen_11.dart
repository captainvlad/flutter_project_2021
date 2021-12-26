import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/screens/screen_08.dart';
import 'package:sequel/screens/screen_10.dart';
import 'package:sequel/screens/screen_13.dart';
import 'package:sequel/screens/screen_15.dart';
import 'package:sequel/screens/screen_16.dart';

class Screen11 extends StatelessWidget {
  const Screen11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DownloadBloc _dBloc = BlocProvider.of<DownloadBloc>(context);
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<DownloadBloc, DownloadState>(
              builder: (context, state) {
            print("${state.downloadResult}");

            switch (state.downloadResult) {
              case DownloadResult.raw:
                _dBloc.add(DownloadEvent.updateQuestions);
                return const Screen15();
              case DownloadResult.progress:
                return const Screen15();
              case DownloadResult.success:
                return Screen13(
                  title: success,
                );
              case DownloadResult.connectionError:
                return const Screen16();
              case DownloadResult.memoryError:
                return const Screen10();
              case DownloadResult.otherError:
                return Screen13(
                  title: error,
                );
              default:
                break;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  height: uiManager.blockSizeVertical * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: questions_available,
                      size: uiManager.blockSizeVertical * 4,
                      strokeWidth: uiManager.blockSizeVertical * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.questionsAvailable}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      color: yellowColor,
                      cornerRaidus: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: questions_used,
                      size: uiManager.blockSizeVertical * 4,
                      strokeWidth: uiManager.blockSizeVertical * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    UiManager.getCard(
                      label: UiManager.getText(
                        text: "${state.questionsUsed}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      color: yellowColor,
                      cornerRaidus: 10,
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
                    UiManager.getText(
                      text: questions_to_upload,
                      size: uiManager.blockSizeVertical * 4,
                      strokeWidth: uiManager.blockSizeVertical * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 5,
                    ),
                    UiManager.getButton(
                      label: UiManager.getText(
                        text: "${state.questionsToUpload}",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      color: yellowColor,
                      cornerRaidus: 10,
                      onTap: () {
                        _dBloc.add(DownloadEvent.changeUploadQuestions);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiManager.getText(
                      text: remove_previous,
                      size: uiManager.blockSizeVertical * 4,
                      strokeWidth: uiManager.blockSizeVertical * 0,
                      fillColor: whiteColor,
                      strokeColor: whiteColor,
                    ),
                    SizedBox(
                      width: uiManager.blockSizeHorizontal * 8,
                    ),
                    UiManager.getButton(
                      label: UiManager.getText(
                        text: state.removePrevious ? "True" : "False",
                        size: uiManager.blockSizeVertical * 3,
                        strokeWidth: uiManager.blockSizeVertical * 1,
                        fillColor: whiteColor,
                        strokeColor: blueColor,
                      ),
                      width: uiManager.blockSizeHorizontal * 30,
                      height: uiManager.blockSizeVertical * 6,
                      color: yellowColor,
                      cornerRaidus: 10,
                      onTap: () {
                        _dBloc.add(DownloadEvent.removePreviousQuestions);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 4,
                ),
                UiManager.getButton(
                  label: UiManager.getText(
                    text: button_10,
                    size: uiManager.blockSizeVertical * 3,
                    strokeWidth: uiManager.blockSizeVertical * 1,
                    strokeColor: blueColor,
                    fillColor: whiteColor,
                  ),
                  width: uiManager.blockSizeHorizontal * 60,
                  height: uiManager.blockSizeVertical * 6,
                  color: yellowColor,
                  cornerRaidus: 10,
                  onTap: () {
                    _dBloc.add(DownloadEvent.download);
                  },
                ),
                SizedBox(
                  height: uiManager.blockSizeVertical * 2,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
