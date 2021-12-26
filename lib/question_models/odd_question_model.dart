import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/question_model_interface.dart';
import 'package:sequel/managers/api_manager.dart';
import 'package:sequel/res/values/strings.dart';

// Cost of question: 253 API calls

class OddQuestionModel extends QuestionModelInterface {
  @override
  Future<Question> generateQuestion(
    Map<String, dynamic> responseBody,
  ) async {
    Map<String, List<String>> actorFilmsMap = {};
    Map<String, String> actorIdImageMap = {};

    List<dynamic> filmList = responseBody["items"];

    for (Map<String, dynamic> film in filmList) {
      Map<String, dynamic> filmCast =
          await ApiManager().getFilmFulcastById(film['id']);

      List<dynamic> filmActors = filmCast["actorList"];
      int topActorsRange = 20;

      for (int i = 0; i < topActorsRange; i++) {
        dynamic actor = filmActors[i];
        String actorId = actor['id'];
        String actorImage = actor['image'];

        if (!actorIdImageMap.containsKey(actorId)) {
          actorIdImageMap[actorId] = actorImage;
        }

        if (actorFilmsMap.containsKey(actorId)) {
          List<String> actorFilms = actorFilmsMap[actorId]!;
          actorFilms.add(film['title']);
          actorFilmsMap[actorId] = actorFilms;
        } else {
          actorFilmsMap[actorId] = [film['title']];
        }
      }
    }

    String pictureActorImage = "";
    String pictureActorId = "";

    List<String> variants = [];
    String rightAnswer = "";

    List<String> actorIds = actorFilmsMap.keys.toList();
    List<List<String>> actorsIdsFilms = actorFilmsMap.values.toList();

    actorIds.shuffle();
    actorsIdsFilms.shuffle();

    for (String actorId in actorIds) {
      List<String> actorFilms = actorFilmsMap[actorId]!;

      if (actorFilms.length >= 3 && pictureActorImage.isEmpty) {
        actorFilms.shuffle();

        pictureActorImage = actorIdImageMap[actorId]!;
        variants = actorFilms.sublist(0, 3);
        pictureActorId = actorId;
        break;
      }
    }

    for (List<String> actorsFilms in actorsIdsFilms) {
      bool variantsFound = false;
      List<String> pictureActorFilms = actorFilmsMap[pictureActorId]!;

      for (String film in actorsFilms) {
        if (!pictureActorFilms.contains(film)) {
          variantsFound = true;
          variants.add(film);
          rightAnswer = film;
          break;
        }
      }

      if (variantsFound) {
        variants.shuffle();
        break;
      }
    }

    return Question(
      title: oddFilmByImageTitle,
      imagePath: pictureActorImage,
      rightAnswer: rightAnswer,
      variants: variants,
    );
  }
}
