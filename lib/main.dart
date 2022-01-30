import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/bullet_quiz_bloc.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/blocs/statistics_bloc.dart';
import 'package:sequel/screens/bullet_quiz_end_screen.dart';
import 'package:sequel/screens/bullet_quiz_question_screen.dart';
import 'package:sequel/screens/classic_quiz_end_screen.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/screens/home_screen.dart';
import 'package:sequel/screens/game_config_screen.dart';
import 'package:sequel/screens/stats_screen.dart';
import 'package:sequel/screens/setting_screen.dart';
import 'package:sequel/screens/about_app_screen.dart';
import 'package:sequel/screens/achievements_screen.dart';
import 'package:sequel/screens/detailed_achievement_screen.dart';
import 'package:sequel/screens/no_internet_screen.dart';
import 'package:sequel/screens/no_questions_screen.dart';
import 'package:sequel/screens/no_memory_screen.dart';
import 'package:sequel/screens/download_questions_screen.dart';
import 'package:sequel/screens/loading_screen.dart';
import 'package:sequel/screens/under_construction_screen.dart';
import 'package:sequel/screens/classic_quiz_question_screen.dart';
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
          navigatorKey: NavigationManager.navigatorKey,
          initialRoute: '/home_screen',
          routes: {
            '/detailed_achievement_screen': (context) =>
                const DetailedAchievementScreen(),
            '/download_questions_screen': (context) =>
                const DownloadQuestionsScreen(),
            '/under_construction_screen': (context) =>
                const UnderConstructionScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/stats_screen': (context) => const StatsScreen(),
            '/setting_screen': (context) => const SettingScreen(),
            '/about_app_screen': (context) => const AboutAppScreen(),
            '/achievements_screen': (context) => const AchievementsScreen(),
            '/no_internet_screen': (context) => const NoInternetScreen(),
            '/no_questions_screen': (context) => const NoQuestionsScreen(),
            '/no_memory_screen': (context) => const NoMemoryScreen(),
            '/loading_screen': (context) => const LoadingScreen(),
            '/game_config_screen': (context) => const GameConfigScreen(),
            '/bullet_end_screen': (context) => const BulletQuizEndScreen(),
            '/classic_end_screen': (context) => const ClassicQuizEndScreen(),
            '/classic_quiz_question_screen': (context) =>
                BlocProvider<ClassicQuizBloc>(
                  create: (context) => ClassicQuizBloc(),
                  child: const ClassicQuizQuestionScreen(),
                ),
            '/bullet_quiz_question_screen': (context) =>
                BlocProvider<BulletQuizBloc>(
                  create: (context) => BulletQuizBloc(),
                  child: const BulletQuizQuestionScreen(),
                ),
          },
        ),
      ),
    ),
  );
}
