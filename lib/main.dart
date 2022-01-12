import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/blocs/statistics_bloc.dart';
import 'package:sequel/screens/classic_quiz_end_screen.dart';
import 'package:sequel/screens/remove_later.dart';
import 'package:sequel/screens/home_screen.dart';
import 'package:sequel/screens/settings_screen.dart';
import 'package:sequel/screens/screen_03.dart';
import 'package:sequel/screens/screen_04.dart';
import 'package:sequel/screens/screen_05.dart';
import 'package:sequel/screens/screen_06.dart';
import 'package:sequel/screens/screen_07.dart';
import 'package:sequel/screens/screen_08.dart';
import 'package:sequel/screens/screen_09.dart';
import 'package:sequel/screens/screen_10.dart';
import 'package:sequel/screens/screen_11.dart';
import 'package:sequel/screens/screen_12.dart';
import 'package:sequel/screens/loading_screen.dart';
import 'package:sequel/screens/screen_17.dart';
import 'package:sequel/screens/classic_quiz_question_screen.dart';
import 'package:sequel/screens/screen_animation_sample.dart';
import 'res/values/colors.dart';

void main() {
  SystemUiOverlayStyle mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: blueColor,
    statusBarColor: blueColor,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<DownloadBloc>(
            create: (context) => DownloadBloc(),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<StatisticsBloc>(
            create: (context) => StatisticsBloc(),
          ),
          BlocProvider<GameConfigBloc>(
            create: (context) => GameConfigBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: blueColor,
            fontFamily: 'Ultra',
          ),
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: '/home_screen',
          routes: {
            '/home_screen': (context) => const HomeScreen(),
            '/screen_03': (context) => const Screen03(),
            '/screen_04': (context) => const Screen04(),
            '/screen_05': (context) => const Screen05(),
            '/screen_06': (context) => const Screen06(),
            '/screen_07': (context) => Screen07(),
            '/screen_08': (context) => const Screen08(),
            '/screen_09': (context) => const Screen09(),
            '/screen_10': (context) => const Screen10(),
            '/screen_11': (context) => const Screen11(),
            '/screen_12': (context) => const Screen12(),
            '/loading_screen': (context) => const LoadingScreen(),
            '/screen_17': (context) => const Screen17(),
            '/settings_screen': (context) => const SettingsScreen(),
            '/classic_end_screen': (context) => const ClassicQuizEndScreen(),
            '/classic_quiz_question_screen': (context) =>
                BlocProvider<ClassicQuizBloc>(
                  create: (context) => ClassicQuizBloc(),
                  child: const ClassicQuizQuestionScreen(),
                ),
          },
        ),
      ),
    ),
  );

  //     (value) {
  //   runApp(
  //     MaterialApp(
  //       home: Scaffold(
  //         body: MyApp2(),
  //       ),
  //       navigatorKey: NavService.navigatorKey,
  //       routes: {
  //         '/home': (context) => const Screen01(),
  //       },
  //     ),
  //   );
  // });
}
