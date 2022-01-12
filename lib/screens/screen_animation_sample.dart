// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sequel/screens/remove_later.dart';
// import 'package:sequel/screens/screen_01.dart';

// import '../main.dart';

// enum TimerEvent {
//   ready,
//   start,
// }

// class TimerState extends Equatable {
//   int version;
//   int duration;

//   @override
//   List<Object?> get props => [version, duration];

//   TimerState({
//     this.version = 0,
//     this.duration = 0,
//   });

//   void updateTimer(int currentDuration) {
//     duration = currentDuration;
//     version++;
//   }
// }

// class TimerBloc extends Bloc<TimerEvent, TimerState> {
//   static int duration = 0;

//   TimerBloc() : super(TimerState());

//   @override
//   Stream<TimerState> mapEventToState(TimerEvent event) async* {
//     if (event == TimerEvent.ready) {
//       state.version++;
//     } else {
//       for (int i = 0; i < duration; i++) {
//         await Future.delayed(
//           const Duration(seconds: 1),
//         );
//         state.updateTimer(duration - i);

//         yield TimerState(
//           duration: state.duration,
//         );
//       }

//       print("AAADIP REDIRECTING 0");
//       // print(navigatorKey);
//       // print(navigatorKey.currentState);
//      NavigationService.navigatorKey.currentState!.pushNamed(
//        '/home',
//        arguments: {"a": "ab"},
//      );
//     }
//   }
// }

// class MyApp2 extends StatelessWidget {
//   final int duration;

//   MyApp2({
//     Key? key,
//     this.duration = 10,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<TimerBloc>(
//       create: (context) => TimerBloc(),
//       child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
//         TimerBloc.duration = duration;
//         TimerBloc _tmBloc = BlocProvider.of<TimerBloc>(context);

//         if (state.duration == -1) {
//           print("AAADIP REDIRECTING");
//           return const Screen01();
//         } else {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 state.duration.toString(),
//               ),
//               FloatingActionButton(
//                 onPressed: () {
//                   _tmBloc.add(TimerEvent.start);
//                 },
//               )
//             ],
//           );
//         }
//       }),
//     );

//     // return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
//     //   if (state.duration == 1) {
//     //     print("AAADIP REDIRECTING");
//     //     // Navigator.push(
//     //     //   context,
//     //     //   MaterialPageRoute(builder: (context) => const Screen01()),
//     //     // );

//     //     return const Screen01();
//     //   } else {
//     //     return Column(
//     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       children: [
//     //         Text(
//     //           state.duration.toString(),
//     //         ),
//     //         FloatingActionButton(
//     //           onPressed: () {
//     //             _tmBloc.add(TimerEvent.start);
//     //           },
//     //         )
//     //       ],
//     //     );
//     //   }
//     // });
//   }
// }
