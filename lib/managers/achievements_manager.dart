import 'package:sequel/res/values/strings.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/db_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future getAchievementsNumber() async {
    List<Achievement> achievements = await getAchievementsCasted();
    return achievements.length;
  }

  Future<List<Achievement>> getAchievementsCasted() async {
    List<dynamic> queryRows = await getAchievements();

    return queryRows
        .map(
          (element) => Achievement(
            name: element["name"],
            description: element["description"],
            imagePath: element["image_path"],
            unlocked: element["unlocked"] == 1,
          ),
        )
        .toList();
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

  Future lockAllItems() async {
    List<Achievement> la = await getAchievementsCasted();

    for (Achievement element in la) {
      await DbManager.runUpdateQuery(
        '''
      UPDATE $achievementsTable
      SET unlocked = 0
      WHERE name = '${element.name}'
      ''',
      );
    }
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

  Future<List<String>> checkForUnlockedAchievementsBullet(
    bool hardLevel,
    bool multiPlayerOn,
    Map<String, dynamic> bulletStats,
  ) async {
    List<String> result = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

// Gordon Gekko unlocking
    bool allAnswersCorrect = bulletStats["accuracy"] == "100.0%";

    bool allAnswersWrong = bulletStats["accuracy"] == "0.0%" &&
        int.parse(bulletStats["all_answers"]) > 0;

// Rocky Balboa unlocking
    int? recordStreak = pref.getInt("record_breaking_strike");
    int? previousRecord = pref.getInt("bullet_record");
    int correctAnswers = int.parse(bulletStats["correct_answers"]);

    if (previousRecord == null || recordStreak == null) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", 0);
    } else if (correctAnswers > previousRecord && recordStreak < 2) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", recordStreak + 1);
    } else if (correctAnswers > previousRecord && recordStreak >= 2) {
      pref.setInt("bullet_record", correctAnswers);
      pref.setInt("record_breaking_strike", recordStreak + 1);
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(rocky_balboa);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Alan Turing unlocking
    if (allAnswersCorrect && hardLevel) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(alan_turing);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// The Dude unlocking
    if (multiPlayerOn) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(the_dude);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// 'Ace' and Nicky unlocking
    if (allAnswersWrong) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(ace_nicky);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Badcomedian unlocking
    int achievementsUnlocked = 0;
    List<Achievement> achi = await AchievementsManager()
        .getAchievementsCasted(); // Make new method for getting unlocked achievements

    for (Achievement a in achi) {
      if (a.unlocked) {
        achievementsUnlocked++;
      }
    }

    if (achievementsUnlocked >= 6) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(badcomedian);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

    return result;
  }

  Future<List<String>> checkForUnlockedAchievementsClassic(
    bool hardLevel,
    bool multiPlayerOn,
    Map<String, dynamic> bulletStats,
  ) async {
    List<String> result = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

// Gordon Gekko unlocking
    bool allAnswersCorrect = bulletStats["accuracy"] == "100.0%";

    bool allAnswersWrong = bulletStats["accuracy"] == "0.0%" &&
        int.parse(bulletStats["all_answers"]) > 0;

    if (allAnswersCorrect) {
      int? winningStreak = pref.getInt("winning_strike");

      if (winningStreak == null) {
        pref.setInt("winning_strike", 1);
      } else if (winningStreak < 2) {
        pref.setInt("winning_strike", winningStreak + 1);
      } else {
        Achievement unlockedAchievement =
            await AchievementsManager().getAchievementByName(gordon_gekko);

        if (!unlockedAchievement.unlocked) {
          result.add(unlockedAchievement.name);
          AchievementsManager().unlockItem(unlockedAchievement, 1);
        }
      }
    } else {
      pref.setInt("winning_strike", 0);
    }

// Flash unlocking
    if (int.parse(bulletStats["total_time"][0]) < 2) {
      // Fix this later!
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(flash);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Alan Turing unlocking
    if (allAnswersCorrect && hardLevel) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(alan_turing);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// The Dude unlocking
    if (multiPlayerOn) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(the_dude);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// 'Ace' and Nicky unlocking
    if (allAnswersWrong) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(ace_nicky);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

// Badcomedian unlocking
    int achievementsUnlocked = 0;
    List<Achievement> achi =
        await AchievementsManager().getAchievementsCasted();

    for (Achievement a in achi) {
      if (a.unlocked) {
        achievementsUnlocked++;
      }
    }

    if (achievementsUnlocked >= 6) {
      Achievement unlockedAchievement =
          await AchievementsManager().getAchievementByName(badcomedian);

      if (!unlockedAchievement.unlocked) {
        result.add(unlockedAchievement.name);
        AchievementsManager().unlockItem(unlockedAchievement, 1);
      }
    }

    return result;
  }
}
