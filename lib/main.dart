import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/blocs/statistics_bloc.dart';
import 'package:sequel/screens/screen_01.dart';
import 'package:sequel/screens/screen_02.dart';
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
import 'package:sequel/screens/screen_17.dart';
import 'package:sequel/screens/screen_18.dart';
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
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<DownloadBloc>(
            create: (context) => DownloadBloc(),
          ),
          BlocProvider<StatisticsBloc>(
            create: (context) => StatisticsBloc(),
          ),
          BlocProvider<GameConfigBloc>(
            create: (context) => GameConfigBloc(),
          ),
          BlocProvider<ClassicQuizBloc>(
            create: (context) => ClassicQuizBloc(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: blueColor,
            fontFamily: 'Ultra',
          ),
          initialRoute: '/screen_01',
          routes: {
            '/screen_01': (context) => const Screen01(),
            '/screen_02': (context) => const Screen02(),
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
            '/screen_17': (context) => const Screen17(),
            '/screen_18': (context) => const Screen18(),
          },
        ),
      ),
    ),
  );
}
