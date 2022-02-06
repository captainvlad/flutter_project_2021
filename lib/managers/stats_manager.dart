import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/db_manager.dart';

class StatsManager {
  static const String statsTable = "statistics";

  Future createStatsTable() async {
    await DbManager.instance.createTable(
      '''CREATE TABLE IF NOT EXISTS $statsTable (
        id INTEGER PRIMARY KEY,
        total_played_minutes INTEGER DEFAULT 0,
        total_games_played INTEGER DEFAULT 0,
        total_games_played_classic INTEGER DEFAULT 0,
        total_games_played_bullet INTEGER DEFAULT 0,
        average_accuracy_classic INTEGER DEFAULT 0,
        average_accuracy_bullet INTEGER DEFAULT 0,
        achievements_number INTEGER DEFAULT 0,
        downloaded_questions INTEGER DEFAULT 0,
        downloaded_used_questions INTEGER DEFAULT 0
      )''',
    );
  }

  Future _addStatistics(Statistic statistic) async {
    await DbManager.runSelectQuery(
      '''
        INSERT INTO $statsTable(
          total_played_minutes,
          total_games_played,
          average_accuracy_classic,
          average_accuracy_bullet,
          achievements_number,
          downloaded_questions,
          downloaded_used_questions,
          average_accuracy_classic,
          average_accuracy_bullet
        ) VALUES (
          ${statistic.totalPlayTime},
          ${statistic.totalGamesPlayed},
          ${statistic.avgAccuracyBullet},
          ${statistic.avgAccuracyClassic},
          ${statistic.achievementsNumber},
          ${statistic.downloadedQuestions},
          ${statistic.downloadedUsedQuestions},
          ${statistic.totalGamesPlayedClassic},
          ${statistic.totalGamesPlayedBullet}
        )
      ''',
    );
  }

  Future _setDefaultStats() async {
    await _addStatistics(
      Statistic(
        totalPlayTime: 0,
        totalGamesPlayed: 0,
        avgAccuracyBullet: 0,
        avgAccuracyClassic: 0,
        achievementsNumber: 0,
        downloadedQuestions: 0,
        totalGamesPlayedBullet: 0,
        downloadedUsedQuestions: 0,
        totalGamesPlayedClassic: 0,
      ),
    );
  }

  Future clearStatsTable() async {
    await DbManager.runSelectQuery(
      '''DELETE FROM $statsTable''',
    );
  }

  Future removeStatsTable() async {
    await DbManager.runSelectQuery(
      '''DROP TABLE IF EXISTS $statsTable''',
    );
  }

  Future<Statistic?> getStatistics() async {
    dynamic query = await DbManager.runSelectQuery(
      '''SELECT * FROM $statsTable''',
    );

    if (query.isEmpty) {
      return null;
    }

    return Statistic(
      totalPlayTime: query[0]["total_played_minutes"],
      totalGamesPlayed: query[0]["total_games_played"],
      achievementsNumber: query[0]["achievements_number"],
      downloadedQuestions: query[0]["downloaded_questions"],
      avgAccuracyBullet: query[0]["average_accuracy_bullet"],
      avgAccuracyClassic: query[0]["average_accuracy_classic"],
      downloadedUsedQuestions: query[0]["downloaded_used_questions"],
      totalGamesPlayedBullet: query[0]["total_games_played_bullet"],
      totalGamesPlayedClassic: query[0]["total_games_played_classic"],
    );
  }

  Future updateBulletStatistics(Statistic statistic) async {
    Statistic? currentStatistic = await getStatistics();

    if (currentStatistic == null) {
      await _setDefaultStats();
      return;
    }

    int totalPlayedMinutes =
        currentStatistic.totalPlayTime + statistic.totalPlayTime;

    int totalGamesPlayed =
        currentStatistic.totalGamesPlayed + statistic.totalGamesPlayed;

    int averageAccuracyBullet = ((currentStatistic.avgAccuracyBullet *
                    (currentStatistic.totalGamesPlayedBullet) +
                statistic.avgAccuracyBullet) /
            (currentStatistic.totalGamesPlayedBullet + 1))
        .round();

    int downloadedUsedQuestions = currentStatistic.downloadedUsedQuestions +
        statistic.downloadedUsedQuestions;

    await DbManager.runUpdateQuery(
      '''
      UPDATE $statsTable SET
        total_played_minutes=$totalPlayedMinutes,
        total_games_played=$totalGamesPlayed,
        average_accuracy_bullet=$averageAccuracyBullet,
        downloaded_used_questions=$downloadedUsedQuestions,
        total_games_played_bullet=${currentStatistic.totalGamesPlayedBullet + 1}
      WHERE id=1
      ''',
    );
  }

  Future updateClassicStatistics(Statistic statistic) async {
    Statistic? currentStatistic = await getStatistics();

    if (currentStatistic == null) {
      await _setDefaultStats();
      return;
    }

    int totalPlayedMinutes =
        currentStatistic.totalPlayTime + statistic.totalPlayTime;

    int totalGamesPlayed =
        currentStatistic.totalGamesPlayed + statistic.totalGamesPlayed;

    int averageAccuracyClassic = ((currentStatistic.avgAccuracyClassic *
                    currentStatistic.totalGamesPlayedClassic +
                statistic.avgAccuracyClassic) /
            (currentStatistic.totalGamesPlayedClassic + 1))
        .round();

    int downloadedUsedQuestions = currentStatistic.downloadedUsedQuestions +
        statistic.downloadedUsedQuestions;

    await DbManager.runUpdateQuery(
      '''
      UPDATE $statsTable SET
        total_played_minutes=$totalPlayedMinutes,
        total_games_played=$totalGamesPlayed,
        average_accuracy_classic=$averageAccuracyClassic,
        downloaded_used_questions=$downloadedUsedQuestions,
        total_games_played_classic=${currentStatistic.totalGamesPlayedClassic + 1}
      WHERE id=1
      ''',
    );
  }

  Future resetStatistics() async {
    dynamic currentStatistics = await getStatistics();

    if (currentStatistics == null) {
      await _addStatistics(Statistic(
        totalPlayTime: 0,
        totalGamesPlayed: 0,
        avgAccuracyBullet: 0,
        avgAccuracyClassic: 0,
        achievementsNumber: 0,
        downloadedQuestions: 0,
        totalGamesPlayedBullet: 0,
        downloadedUsedQuestions: 0,
        totalGamesPlayedClassic: 0,
      ));
      return;
    }

    await DbManager.runUpdateQuery(
      '''
      UPDATE $statsTable SET
        total_played_minutes=0,
        total_games_played=0,
        average_accuracy_classic=0,
        average_accuracy_bullet=0,
        achievements_number=0,
        downloaded_questions=0,
        downloaded_used_questions=0,
        total_games_played_classic=0,
        total_games_played_bullet=0
      WHERE id=1
      ''',
    );
  }
}
