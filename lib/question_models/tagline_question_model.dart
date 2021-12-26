import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/question_model_interface.dart';
import 'package:sequel/managers/api_manager.dart';
import 'package:sequel/res/icons/images.dart';

// Cost of question: 3 API calls

class TaglineQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) async {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    var rightAnswer = filmList.last;
    Map<String, dynamic> rightAnswerTaglineJson =
        await ApiManager().getTagLineById(rightAnswer["id"]);

    var rightAnswerTagline = rightAnswerTaglineJson["tagline"];
    List<String> variants = filmList
        .map(
          (element) => element['title'].toString(),
        )
        .toList()
      ..shuffle();

    return Question(
      title: "'$rightAnswerTagline' \n is a tagline of a film:",
      imagePath: filmByTagLineImage,
      rightAnswer: rightAnswer['title'],
      variants: variants,
    );
  }
}
