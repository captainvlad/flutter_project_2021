import 'package:sequel/general_models/question.dart';
import 'package:sequel/res/icons/images.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/general_models/question_model_interface.dart';

// Cost of question: 2 API calls

class BoxOfficeQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(Map<String, dynamic> responseBody) {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    List<dynamic> boxOfficeVariants = _getFilmBoxOffices(filmList);
    List<String> variants = boxOfficeVariants
        .map(
          (element) => element["title"].toString(),
        )
        .toList();

    String rightAnswer = variants.last;
    variants.shuffle();

    return Future(() {
      return Question(
        title: biggestBoxOfficeTitle,
        imagePath: biggestBoxOfficeQuestionImage,
        rightAnswer: rightAnswer,
        variants: variants,
      );
    });
  }

  List<dynamic> _getFilmBoxOffices(List<dynamic> films) {
    // Max box office goes last
    films.sort(
      (a, b) => a['worldwideLifetimeGross'].replaceAll("[^\\d.]", "").compareTo(
            b['worldwideLifetimeGross'].replaceAll("[^\\d.]", ""),
          ),
    );
    return films;
  }
}
