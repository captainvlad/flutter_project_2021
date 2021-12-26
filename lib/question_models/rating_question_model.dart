import 'package:sequel/general_models/question.dart';
import 'package:sequel/res/icons/images.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/general_models/question_model_interface.dart';

// Cost of question: 1 API call

class RatingQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(Map<String, dynamic> responseBody) {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    List<String> variants = _getRatingVariants(filmList);
    String answer = variants.last;
    variants.shuffle();

    return Future(() {
      return Question(
        title: topRatingTitle,
        imagePath: topRatingQuestionImage,
        rightAnswer: answer,
        variants: variants,
      );
    });
  }

  List<String> _getRatingVariants(List<dynamic> films) {
    // Top rating goes last
    films.sort(
      (a, b) => double.parse(a['imDbRating'])
          .compareTo(double.parse(a['imDbRating'])),
    );

    return films
        .map(
          (e) => e['title'].toString(),
        )
        .toList();
  }
}
