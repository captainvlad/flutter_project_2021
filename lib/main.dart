import 'res/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sequel/blocs/stats_bloc.dart';
import 'package:sequel/res/values/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/blocs/download_bloc.dart';
import 'package:sequel/blocs/settings_bloc.dart';
import 'package:sequel/screens/home_screen.dart';
import 'package:sequel/screens/stats_screen.dart';
import 'package:sequel/blocs/bullet_quiz_bloc.dart';
import 'package:sequel/blocs/game_config_bloc.dart';
import 'package:sequel/screens/loading_screen.dart';
import 'package:sequel/screens/settings_screen.dart';
import 'package:sequel/blocs/classic_quiz_bloc.dart';
import 'package:sequel/screens/greetings_screen.dart';
import 'package:sequel/screens/about_app_screen.dart';
import 'package:sequel/screens/game_config_screen.dart';
import 'package:sequel/screens/no_internet_screen.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/screens/achievements_screen.dart';
import 'package:sequel/screens/no_questions_screen.dart';
import 'package:sequel/screens/bullet_quiz_end_screen.dart';
import 'package:sequel/screens/classic_quiz_end_screen.dart';
import 'package:sequel/screens/download_questions_screen.dart';
import 'package:sequel/screens/under_construction_screen.dart';
import 'package:sequel/screens/detailed_achievement_screen.dart';
import 'package:sequel/screens/bullet_quiz_question_screen.dart';
import 'package:sequel/screens/classic_quiz_question_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(appTheme);

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
          BlocProvider<StatsBloc>(
            create: (context) => StatsBloc(),
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
            '/detailed_achievement_screen': (context) =>
                const DetailedAchievementScreen(),
            '/download_questions_screen': (context) =>
                const DownloadQuestionsScreen(),
            '/under_construction_screen': (context) =>
                const UnderConstructionScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/stats_screen': (context) => const StatsScreen(),
            '/loading_screen': (context) => const LoadingScreen(),
            '/settings_screen': (context) => const SettingsScreen(),
            '/about_app_screen': (context) => const AboutAppScreen(),
            '/greetings_screen': (context) => const GreetingsScreen(),
            '/no_internet_screen': (context) => const NoInternetScreen(),
            '/game_config_screen': (context) => const GameConfigScreen(),
            '/no_questions_screen': (context) => const NoQuestionsScreen(),
            '/bullet_end_screen': (context) => const BulletQuizEndScreen(),
            '/achievements_screen': (context) => const AchievementsScreen(),
            '/classic_end_screen': (context) => const ClassicQuizEndScreen(),
          },
        ),
      ),
    ),
  );
}
