import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/statistics_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StatisticsEvent {
  update,
  reset,
}

enum StatisticsStatus {
  none,
  progress,
  failure,
  success,
}

class StatisticsState extends Equatable {
  late int version;
  late StatisticsStatus status;
  late int totalGamesPlayed;
  late int averageAccuracyCla;
  late int averageAccuracyBul;
  late int achievementsNumber;
  late int totalPlayedMinutes;

  StatisticsManager statsManager = StatisticsManager();
  AchievementsManager achievementsManager = AchievementsManager();

  StatisticsState({
    this.version = 0,
    this.status = StatisticsStatus.none,
    this.totalGamesPlayed = 0,
    this.totalPlayedMinutes = 0,
    this.averageAccuracyCla = 0,
    this.averageAccuracyBul = 0,
    this.achievementsNumber = 0,
  });

  @override
  List<Object?> get props => [
        version,
        status,
        totalGamesPlayed,
        averageAccuracyCla,
        averageAccuracyBul,
        achievementsNumber,
      ];

  Future updateStats() async {
    Statistic? stats = await statsManager.getStatistics();

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
    yield StatisticsState(
      status: StatisticsStatus.progress,
      totalGamesPlayed: state.totalGamesPlayed,
      totalPlayedMinutes: state.totalPlayedMinutes,
      averageAccuracyCla: state.averageAccuracyCla,
      averageAccuracyBul: state.averageAccuracyBul,
      achievementsNumber: state.achievementsNumber,
    );

    if (event == StatisticsEvent.update) {
      try {
        await Future.delayed(const Duration(seconds: 5));
        await state.updateStats();

        yield StatisticsState(
          status: StatisticsStatus.success,
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      } catch (e) {
        print("FUCKING ERROR"); // AAADIP remove later
        print(e);

        yield StatisticsState(
          status: StatisticsStatus.failure,
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      }
    } else if (event == StatisticsEvent.reset) {
      try {
        await Future.delayed(const Duration(seconds: 5));
        await state.resetStats();
        await state.updateStats();

        yield StatisticsState(
          status: StatisticsStatus.success,
          totalGamesPlayed: state.totalGamesPlayed,
          totalPlayedMinutes: state.totalPlayedMinutes,
          averageAccuracyCla: state.averageAccuracyCla,
          averageAccuracyBul: state.averageAccuracyBul,
          achievementsNumber: state.achievementsNumber,
        );
      } catch (e) {
        print("FUCKING ERROR"); // AAADIP remove later
        print(e);

        yield StatisticsState(
          status: StatisticsStatus.failure,
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
