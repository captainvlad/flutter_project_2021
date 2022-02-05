import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/statistics_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StatisticsEvent {
  update,
  reset,
}

class StatisticsState extends Equatable {
  late int version;
  late int totalGamesPlayed;
  late int averageAccuracyCla;
  late int averageAccuracyBul;
  late int achievementsNumber;
  late int totalPlayedMinutes;

  StatisticsManager statsManager = StatisticsManager();
  AchievementsManager achievementsManager = AchievementsManager();

  StatisticsState({
    this.version = 0,
    this.totalGamesPlayed = 0,
    this.totalPlayedMinutes = 0,
    this.averageAccuracyCla = 0,
    this.averageAccuracyBul = 0,
    this.achievementsNumber = 0,
  });

  @override
  List<Object?> get props => [
        version,
        totalGamesPlayed,
        averageAccuracyCla,
        averageAccuracyBul,
        achievementsNumber,
      ];

  Future updateStats() async {
    Statistic? stats = await statsManager.getStatistics();
    achievementsNumber = 0;

    totalGamesPlayed = stats!.totalGamesPlayed;
    totalPlayedMinutes = stats.totalPlayTime;
    averageAccuracyCla = stats.avgAccuracyClassic;
    averageAccuracyBul = stats.avgAccuracyBullet;

    List<Achievement> achievements =
        await AchievementsManager().getAchievementsCasted();

    for (Achievement element in achievements) {
      if (element.unlocked) {
        achievementsNumber++;
      }
    }

    version++;
  }

  Future resetStats() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setInt("bullet_record", 0);
    pref.setInt("winning_strike", 0);
    pref.setInt("record_breaking_strike", 0);

    print("PREF VALUES");

    pref.getKeys().forEach(
          (key) => print("$key: ${pref.get(key).toString()}"),
        );

    achievementsNumber = 0;
    await statsManager.resetStatistics();
    await AchievementsManager().lockAllItems();
    await QuestionsCacheManager().removeAllQuestions();
  }
}

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(StatisticsState());

  @override
  Stream<StatisticsState> mapEventToState(StatisticsEvent event) async* {
    NavigationManager.navigatorKey.currentState!.pushNamed("/loading_screen");

    if (event == StatisticsEvent.update) {
      try {
        await state.updateStats();
        await Future.delayed(const Duration(seconds: 5));

        NavigationManager.navigatorKey.currentState!.pop();

        yield StatisticsState(
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      } catch (e) {
        print("FUCKING ERROR"); // AAADIP remove later
        print(e);

        NavigationManager.navigatorKey.currentState!.pushNamed(
          "/greetings_screen",
          arguments: {"text": "Sorry, something went wrong"},
        );

        yield StatisticsState(
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      }
    } else {
      try {
        await Future.delayed(const Duration(seconds: 5));
        await state.resetStats();
        await state.updateStats();

        NavigationManager.navigatorKey.currentState!.pop();

        yield StatisticsState(
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      } catch (e) {
        print("FUCKING ERROR"); // AAADIP remove later
        print(e);

        NavigationManager.navigatorKey.currentState!.pushNamed(
          "/greetings_screen",
          arguments: {"text": "Sorry, something went wrong"},
        );

        yield StatisticsState(
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      }
    }
  }
}
