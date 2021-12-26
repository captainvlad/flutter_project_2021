import 'package:sequel/general_models/question.dart';
import 'package:sequel/res/icons/images.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/general_models/question_model_interface.dart';

// Cost of question: 1 API call

class OldestQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    List<dynamic> filmVariants = _sortByYears(filmList);
    List<String> variants = filmVariants
        .map(
          (film) => film["title"].toString(),
        )
        .toList();

    String rightAnswer = variants.first;
    variants.shuffle();

    return Future(() {
      return Question(
        title: oldestQuestionTitle,
        imagePath: oldestQuestionImage,
        rightAnswer: rightAnswer,
        variants: variants,
      );
    });
  }

  @override
  List<dynamic> getFourRandomFilms(List<dynamic> films) {
    films.shuffle();

    List<dynamic> result = [];
    List<dynamic> uniqueYears = [];

    for (dynamic film in films) {
      if (!uniqueYears.contains(film['year'])) {
        result.add(film);
        uniqueYears.add(film['year']);
      }

      if (result.length == 4) {
        break;
      }
    }

    return result;
  }

  List<dynamic> _sortByYears(List<dynamic> films) {
    // Oldest films go first
    films.sort(
      (a, b) => int.parse(a['year']).compareTo(
        int.parse(b['year']),
      ),
    );

    return films;
  }
}
