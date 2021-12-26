import 'package:sequel/general_models/question_model_interface.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/api_manager.dart';
import 'package:sequel/res/values/strings.dart';

// Cost of question: 2 API calls

class ImageQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) async {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    var rightAnswer = filmList.last;
    String rightAnswerTitle = rightAnswer["title"];
    String rightAnswerId = rightAnswer["id"];

    Map<String, dynamic> answerImageJson =
        await ApiManager().getFilmImageById(rightAnswerId);
    String answerImagePath = answerImageJson["items"][0]['image'];

    List<String> variants = filmList
        .map(
          (e) => e["title"].toString(),
        )
        .toList()
      ..shuffle();

    return Question(
      title: filmByImageTitle,
      imagePath: answerImagePath,
      rightAnswer: rightAnswerTitle,
      variants: variants,
    );
  }
}
