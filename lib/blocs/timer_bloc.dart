import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerEvent {
  start,
}

class TimerState extends Equatable {
  int version;
  int currentTime;
  static int timeRange = 10;

  TimerState({
    this.version = 0,
    this.currentTime = -1,
  });

  @override
  List<Object?> get props => [version, currentTime];

  void updateTimer(int currentDuration) {
    currentTime = currentDuration;
    version++;
  }

  void configureState(int allTime) {
    currentTime = -1;
    TimerState.timeRange = allTime;
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Function? onExpired;

  TimerBloc() : super(TimerState());

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (state.currentTime == -1) {
      for (int i = 0; i < TimerState.timeRange; i++) {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        state.updateTimer(TimerState.timeRange - i);

        yield TimerState(
          currentTime: state.currentTime,
        );
      }
    }

    onExpired?.call();
  }

  void configureBloc(Function onEndCallBack, int timeRange) {
    if (onExpired == null) {
      onExpired = onEndCallBack;
      state.configureState(timeRange);
    }
  }
}
