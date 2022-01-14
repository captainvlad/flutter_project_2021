import 'package:flutter/material.dart';
import 'package:sequel/blocs/timer_bloc.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Remove to custom widgets folder later

class TimerWidget extends StatelessWidget {
  final int duration;
  final Function? onExpired;

  const TimerWidget({
    Key? key,
    required this.duration,
    required this.onExpired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(),
      child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
        TimerBloc _tmBloc = BlocProvider.of<TimerBloc>(context);
        _tmBloc.configureBloc(onExpired!, duration);
        _tmBloc.add(TimerEvent.start);

        UiManager uiManager = UiManager(context);

        return UiManager.getText(
          text: state.currentTime == -1
              ? "   -    "
              : formatTime(state.currentTime),
          size: uiManager.blockSizeVertical * 3,
          strokeWidth: uiManager.blockSizeVertical * 0,
          fillColor: whiteColor,
          strokeColor: whiteColor,
        );
      }),
    );
  }

  // Should be removed to Utilities
  String formatTime(int currentTime) {
    String seconds;

    if (currentTime % 60 < 10) {
      seconds = "0${currentTime % 60}";
    } else {
      seconds = "${currentTime % 60}";
    }

    return "${currentTime ~/ 60}:$seconds";
  }
}
