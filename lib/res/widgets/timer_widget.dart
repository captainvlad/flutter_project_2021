import 'package:flutter/material.dart';
import 'package:sequel/blocs/timer_bloc.dart';
import 'package:sequel/managers/ui_manager.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/res/widgets/text_widget.dart';

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

        return CustomTextWidget(
          text: state.currentTime == -1
              ? "   -    "
              : UtilityManager().formatTime(state.currentTime),
          size: uiManager.blockSizeVertical * 3,
        );
      }),
    );
  }
}
