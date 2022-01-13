import 'package:flutter/material.dart';
import 'package:sequel/blocs/timer_bloc.dart';
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
        _tmBloc.configureBloc(onExpired!, 20);
        _tmBloc.add(TimerEvent.start);

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.currentTime == -1 ? "-" : state.currentTime.toString(),
              style: const TextStyle(color: whiteColor),
            )
          ],
        );
      }),
    );
  }
}
