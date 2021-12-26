import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/question_model_interface.dart';
import 'package:sequel/managers/api_manager.dart';
import 'package:sequel/res/values/strings.dart';

// Cost of question: 9 API calls

class DirectorQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) async {
    List<dynamic> filmList = getFourRandomFilms(
      responseBody['items'],
    );

    var rightAnswer = filmList.last;
    String posterPath = rightAnswer['image'];

    List<String> variants = [];

    await Future.forEach(filmList, (dynamic element) async {
      String dir = await getFilmDirectorById(element!["id"]);
      variants.add(dir);
    });

    String rightAnswerDirector = variants.last;
    variants.shuffle();

    return Question(
      title: directorByImageTitle,
      imagePath: posterPath,
      rightAnswer: rightAnswerDirector,
      variants: variants,
    );
  }

  Future<String> getFilmDirectorById(String id) async {
    Map<String, dynamic> sd = await ApiManager().getFilmFulcastById(id);
    return sd["directors"];
  }
}
