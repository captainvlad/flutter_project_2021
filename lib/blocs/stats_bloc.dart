import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/stats_manager.dart';
import 'package:sequel/managers/utility_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StatsEvent {
  update,
  reset,
}

class StatsState extends Equatable {
  late int version;
  late int totalGamesPlayed;
  late int averageAccuracyCla;
  late int averageAccuracyBul;
  late int achievementsNumber;
  late int totalPlayedMinutes;

  StatsManager statsManager = StatsManager();
  AchievementsManager achievementsManager = AchievementsManager();

  StatsState({
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

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(StatsState());

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    NavigationManager.pushNamed("/loading_screen", null);

    if (event == StatsEvent.update) {
      try {
        await state.updateStats();
        await UtilityManager().sleep(seconds: 5);

        NavigationManager.popScreen();
      } catch (e) {
        NavigationManager.pushNamed(
          "/greetings_screen",
          {"text": "Sorry, something went wrong"},
        );
      } finally {
        yield StatsState(
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      }
    } else {
      try {
        await UtilityManager().sleep(seconds: 5);
        await state.resetStats();
        await state.updateStats();

        NavigationManager.popScreen();
      } catch (e) {
        NavigationManager.pushNamed(
          "/greetings_screen",
          {"text": "Sorry, something went wrong"},
        );
      } finally {
        yield StatsState(
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
