import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/questions_types.dart';
import 'package:sequel/managers/api_manager.dart';
import 'package:sequel/question_models/image_question_model.dart';
import 'package:sequel/question_models/tagline_question_model.dart';
import 'package:sequel/question_models/director_question_model.dart';
import 'package:sequel/question_models/box_office_question_model.dart';
import 'package:sequel/question_models/oldest_question_model.dart';
import 'package:sequel/question_models/odd_question_model.dart';
import 'package:sequel/question_models/rating_question_model.dart';

class QuestionsManager {
  late OddQuestionModel odd;
  late OldestQuestionModel oldest;
  late RatingQuestionModel topRating;
  late ImageQuestionModel filmImage;
  late BoxOfficeQuestionModel maxBoxOffice;
  late TaglineQuestionModel filmTagline;
  late DirectorQuestionModel directorPoster;

  QuestionsManager() {
    odd = OddQuestionModel();
    oldest = OldestQuestionModel();
    filmImage = ImageQuestionModel();
    topRating = RatingQuestionModel();
    filmTagline = TaglineQuestionModel();
    maxBoxOffice = BoxOfficeQuestionModel();
    directorPoster = DirectorQuestionModel();
  }

  Future<Question> getQuestion(QuestionType type, String level) async {
    Map<String, dynamic> topFilms;

    if (level == 'Easy') {
      topFilms = await ApiManager().getTop250();
    } else {
      topFilms = await ApiManager().getTop100();
    }

    switch (type) {
      case QuestionType.directorByPosterQuestion:
        return directorPoster.generateQuestion(topFilms);

      case QuestionType.filmByImageQuestion:
        return filmImage.generateQuestion(topFilms);

      case QuestionType.filmByTagline:
        return filmTagline.generateQuestion(topFilms);

      case QuestionType.maxBoxOfficeQuestion:
        Map<String, dynamic> topBoxOfficeFilms =
            await ApiManager().getAllTimeBoxOffice();
        return maxBoxOffice.generateQuestion(topBoxOfficeFilms);

      case QuestionType.oldestFilmQuestion:
        return oldest.generateQuestion(topFilms);

      case QuestionType.oddFilmQuestion:
        // This type is too costly (253 API calls
        // with 100 API calls a day restriction)
        // return odd.generateQuestion(topFilms);
        return Question.emptyQuestion;

      case QuestionType.topRatingQuestion:
        return topRating.generateQuestion(topFilms);
    }
  }
}
