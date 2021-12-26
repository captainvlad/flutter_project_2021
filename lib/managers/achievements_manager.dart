import 'package:sequel/res/values/strings.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/db_manager.dart';

class AchievementsManager {
  static const String achievementsTable = "achievements";

  static final List<Achievement> standardAchievements = [
    Achievement(
      name: gordon_gekko,
      description: gekko_brief,
      imagePath: "assets/images/image_12.png",
    ),
    Achievement(
      name: rocky_balboa,
      description: balboa_brief,
      imagePath: "assets/images/image_28.png",
    ),
    Achievement(
      name: flash,
      description: flash_brief,
      imagePath: "assets/images/image_15.png",
    ),
    Achievement(
      name: alan_turing,
      description: turing_brief,
      imagePath: "assets/images/image_16.png",
    ),
    Achievement(
      name: the_dude,
      description: dude_brief,
      imagePath: "assets/images/image_17.png",
    ),
    Achievement(
      name: ace_nicky,
      description: ace_brief,
      imagePath: "assets/images/image_19.png",
    ),
    Achievement(
      name: badcomedian,
      description: badcomedian_brief,
      imagePath: "assets/images/image_18.png",
    ),
  ];

  Future getAchievements() async {
    return await DbManager.runSelectQuery(
      "SELECT * FROM $achievementsTable",
    );
  }

  Future getAchievementByName(String name) async {
    dynamic achievements = await getAchievements();

    for (dynamic achievement in achievements) {
      if (achievement['name'] == name) {
        return Achievement(
          name: achievement['name'],
          description: achievement['description'],
          imagePath: achievement['image_path'],
          unlocked: achievement['unlocked'] == 1,
        );
      }
    }

    return Achievement(
      name: 'error',
      description: 'error',
      imagePath: '',
    );
  }

  Future unlockItem(Achievement achievement, int value) async {
    await DbManager.runUpdateQuery(
      '''
      UPDATE $achievementsTable
      SET unlocked = $value
      WHERE name = '${achievement.name}'
      ''',
    );
  }

  Future initDatabaseTable() async {
    await createAchievementsTable();
    dynamic currentRows = await getAchievements();

    if (currentRows.length == achievements.length) {
      return;
    }

    for (Achievement achievement in standardAchievements) {
      await DbManager.runAddQuery(
        '''
        INSERT INTO $achievementsTable(name, description,image_path) VALUES (
          '${achievement.name}',
          '${achievement.description}',
          '${achievement.imagePath}'
        )
        ''',
      );
    }
  }

  Future createAchievementsTable() async {
    await DbManager.instance.createTable(
      '''CREATE TABLE IF NOT EXISTS $achievementsTable (
      id INTEGER PRIMARY KEY,
      name TEXT,
      description TEXT,
      image_path TEXT,
      unlocked INTEGER DEFAULT 0
      )''',
    );
  }

  Future clearAchievementsTable() async {
    await DbManager.runSelectQuery(
      '''DELETE FROM $achievementsTable''',
    );
  }

  Future removeAchievementsTable() async {
    await DbManager.runSelectQuery(
      '''DROP TABLE IF EXISTS $achievementsTable''',
    );
  }
}
