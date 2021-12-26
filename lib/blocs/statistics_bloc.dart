import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/managers/statistics_manager.dart';

enum StatisticsEvent {
  update,
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
    dynamic statsRow = await statsManager.getStatistics();

    totalGamesPlayed = statsRow[0]['total_games_played'];
    totalPlayedMinutes = statsRow[0]['total_played_minutes'];
    averageAccuracyCla = statsRow[0]['average_accuracy_classic'];
    averageAccuracyBul = statsRow[0]['average_accuracy_bullet'];

    for (Achievement achievement in AchievementsManager.standardAchievements) {
      Achievement databaseAchievement =
          await achievementsManager.getAchievementByName(achievement.name);

      achievementsNumber = databaseAchievement.unlocked
          ? achievementsNumber + 1
          : achievementsNumber;
    }

    version++;
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
      yield StatisticsState(
        status: StatisticsStatus.failure,
        totalGamesPlayed: state.totalGamesPlayed,
        totalPlayedMinutes: state.totalPlayedMinutes,
        averageAccuracyCla: state.averageAccuracyCla,
        averageAccuracyBul: state.averageAccuracyBul,
        achievementsNumber: state.achievementsNumber,
      );

      await Future.delayed(const Duration(seconds: 5));

      yield StatisticsState(
        status: StatisticsStatus.success,
        totalGamesPlayed: state.totalGamesPlayed,
        totalPlayedMinutes: state.totalPlayedMinutes,
        averageAccuracyCla: state.averageAccuracyCla,
        averageAccuracyBul: state.averageAccuracyBul,
        achievementsNumber: state.achievementsNumber,
      );
    }
  }
}
