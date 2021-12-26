import 'package:sequel/general_models/question.dart';

abstract class QuestionModelInterface {
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) async {
    return Question.emptyQuestion;
  }

  List<dynamic> getFourRandomFilms(List<dynamic> films) {
    films.shuffle();

    return films.sublist(
      films.length - 4,
    );
  }
}
