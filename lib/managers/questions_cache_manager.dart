import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/db_manager.dart';

class QuestionsCacheManager {
  static const String questionsTable = "questions";

  Future cacheItems(List<Question> questions) async {
    for (Question question in questions) {
      cacheItem(question);
    }
  }

  Future cacheItem(Question question) async {
    if (question == Question.emptyQuestion) {
      throw Exception("Attempt to cache empty question");
    }

    return await DbManager.runAddQuery(
      '''INSERT INTO $questionsTable(
        title,
        imagePath,
        rightAnswer,
        variant_1,
        variant_2,
        variant_3,
        variant_4
        ) VALUES(
        '${question.title}',
        '${question.imagePath}',
        '${question.rightAnswer}',
        '${question.variants[0]}',
        '${question.variants[1]}',
        '${question.variants[2]}',
        '${question.variants[3]}'
        )''',
    );
  }

  Future questionInTable(Question question) async {
    if (question == Question.emptyQuestion) {
      throw Exception("Attempt to check empty question");
    }

    List<dynamic> result = await DbManager.runSelectQuery(
      '''SELECT * FROM $questionsTable WHERE
          title='${question.title}' AND
          imagePath='${question.imagePath}' AND
          rightAnswer='${question.rightAnswer}' AND
          variant_1='${question.variants[0]}' AND
          variant_2='${question.variants[1]}' AND
          variant_3='${question.variants[2]}' AND
          variant_4='${question.variants[3]}'
        ''',
    );

    return result.isNotEmpty;
  }

  Future questionIsUsed(Question question) async {
    if (question == Question.emptyQuestion) {
      throw Exception("Attempt to check empty question");
    }

    List<dynamic> result = await DbManager.runSelectQuery(
      '''SELECT * FROM $questionsTable WHERE
        title='${question.title}' AND
        imagePath='${question.imagePath}' AND
        rightAnswer='${question.rightAnswer}' AND
        variant_1='${question.variants[0]}' AND
        variant_2='${question.variants[1]}' AND
        variant_3='${question.variants[2]}' AND
        variant_4='${question.variants[3]}'
      ''',
    );

    return result[0]['used'] == 1;
  }

  Future getAllQuestions() async {
    List<dynamic> result = await DbManager.runSelectQuery(
      '''SELECT * FROM $questionsTable''',
    );

    return result
        .map(
          (e) => queryToQuestion(e),
        )
        .toList();
  }

  Future getQuestionsNumber() async {
    List<dynamic> result = await DbManager.runSelectQuery(
      '''SELECT * FROM $questionsTable''',
    );

    return result.length;
  }

  Question queryToQuestion(dynamic q) {
    return Question(
        title: q['title'],
        imagePath: q['imagePath'],
        rightAnswer: q['rightAnswer'],
        variants: [
          q['variant_1'],
          q['variant_2'],
          q['variant_3'],
          q['variant_4'],
        ]);
  }

  Future removeAllQuestions() async {
    await DbManager.runSelectQuery(
      '''DELETE FROM $questionsTable''',
    );
  }

  Future removeQuestionsTable() async {
    await DbManager.runSelectQuery(
      '''DROP TABLE IF EXISTS $questionsTable''',
    );
  }

  Future createQuestionsTable() async {
    await DbManager.instance.createTable(
      '''CREATE TABLE IF NOT EXISTS $questionsTable (
      id INTEGER PRIMARY KEY,
      title TEXT,
      imagePath TEXT,
      rightAnswer TEXT,
      variant_1 TEXT,
      variant_2 TEXT,
      variant_3 TEXT,
      variant_4 TEXT,
      used INTEGER DEFAULT 0
      )''',
    );
  }

  Future markQuestionUsed(Question question, int value) async {
    if (question == Question.emptyQuestion) {
      throw Exception("Attempt to check empty question");
    }

    if (value != 0 && value != 1) {
      throw Exception("Bad value: neither 0 nor 1");
    }

    await DbManager.runSelectQuery(
      '''UPDATE $questionsTable
        SET
          title='${question.title}',
          imagePath='${question.imagePath}',
          rightAnswer='${question.rightAnswer}',
          variant_1='${question.variants[0]}',
          variant_2='${question.variants[1]}',
          variant_3='${question.variants[2]}',
          variant_4='${question.variants[3]}',
          used='$value'
        WHERE
          title='${question.title}' AND
          imagePath='${question.imagePath}' AND
          rightAnswer='${question.rightAnswer}' AND
          variant_1='${question.variants[0]}' AND
          variant_2='${question.variants[1]}' AND
          variant_3='${question.variants[2]}' AND
          variant_4='${question.variants[3]}'
        ''',
    );
  }
}
