import 'package:sequel/general_models/statistic.dart';
import 'package:sequel/managers/db_manager.dart';

class StatisticsManager {
  static const String statsTable = "statistics";

  Future createStatsTable() async {
    await DbManager.instance.createTable(
      '''CREATE TABLE IF NOT EXISTS $statsTable (
        id INTEGER PRIMARY KEY,
        total_played_minutes INTEGER DEFAULT 0,
        total_games_played INTEGER DEFAULT 0,
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
          downloaded_used_questions
        ) VALUES (
          ${statistic.totalPlayTime},
          ${statistic.totalGamesPlayed},
          ${statistic.avgAccuracyBullet},
          ${statistic.avgAccuracyClassic},
          ${statistic.achievementsNumber},
          ${statistic.downloadedQuestions},
          ${statistic.downloadedUsedQuestions}
        )
      ''',
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

  Future getStatistics() async {
    return await DbManager.runSelectQuery(
      '''SELECT * FROM $statsTable''',
    );
  }

  Future updateStatistics(Statistic statistic) async {
    dynamic currentStatistics = await getStatistics();

    if (currentStatistics.length == 0) {
      await _addStatistics(statistic);
      return;
    }

    int totalPlayedMinutes =
        currentStatistics[0]['total_played_minutes'] + statistic.totalPlayTime;

    int totalGamesPlayed =
        currentStatistics[0]['total_games_played'] + statistic.totalGamesPlayed;

    int averageAccuracyClassic = currentStatistics[0]
            ['average_accuracy_classic'] +
        statistic.avgAccuracyClassic;

    int averageAccuracyBullet = currentStatistics[0]
            ['average_accuracy_bullet'] +
        statistic.avgAccuracyBullet;

    int achievementsNumber = currentStatistics[0]['achievements_number'] +
        statistic.achievementsNumber;

    int downloadedQuestions = currentStatistics[0]['downloaded_questions'] +
        statistic.downloadedQuestions;

    int downloadedUsedQuestions = currentStatistics[0]
            ['downloaded_used_questions'] +
        statistic.downloadedUsedQuestions;

    await DbManager.runUpdateQuery(
      '''
      UPDATE $statsTable SET
        total_played_minutes=$totalPlayedMinutes,
        total_games_played=$totalGamesPlayed,
        average_accuracy_classic=$averageAccuracyClassic,
        average_accuracy_bullet=$averageAccuracyBullet,
        achievements_number=$achievementsNumber,
        downloaded_questions=$downloadedQuestions,
        downloaded_used_questions=$downloadedUsedQuestions
      WHERE id=1
      ''',
    );
  }
}
