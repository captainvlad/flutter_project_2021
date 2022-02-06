import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/general_models/questions_types.dart';
import 'package:sequel/managers/navigation_manager.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/questions_manager.dart';
import 'package:sequel/managers/utility_manager.dart';

enum DownloadEvent {
  download,
  updateQuestions,
  changeUploadQuestions,
  removePreviousQuestions,
}

class DownloadState extends Equatable {
  int version;
  int questionsUsed;
  bool removePrevious;
  int questionsToUpload;
  int questionsAvailable;

  String? gameLevel;

  QuestionsCacheManager cache = QuestionsCacheManager();
  QuestionsManager questions = QuestionsManager();

  DownloadState({
    this.version = 0,
    this.questionsAvailable = -1,
    this.questionsUsed = -1,
    this.questionsToUpload = 10,
    this.removePrevious = false,
    this.gameLevel,
  });

  @override
  List<Object?> get props => [
        version,
        questionsAvailable,
        questionsUsed,
        questionsToUpload,
        removePrevious,
      ];

  Future updateQuestions() async {
    questionsAvailable = 0;
    questionsUsed = 0;

    List<Question> allQuestions = await cache.getAllQuestions();

    for (Question question in allQuestions) {
      bool questionIsUsed = await cache.questionIsUsed(question);

      if (questionIsUsed) {
        questionsUsed++;
      } else {
        questionsAvailable++;
      }
    }

    version++;
  }

  void setStateGameLevel(String level) {
    gameLevel = level;
  }

  void removePreviousChange() {
    removePrevious = !removePrevious;
    version++;
  }

  void questionsToUploadChange() {
    switch (questionsToUpload) {
      case 10:
        questionsToUpload = 20;
        break;
      case 20:
        questionsToUpload = 50;
        break;
      case 50:
        questionsToUpload = 10;
        break;
    }

    version++;
  }

  Future<bool> downloadQuestions() async {
    version++;

    if (removePrevious) {
      await cache.removeAllQuestions();
    }

    // QuestionType.topRatingQuestion is default as
    // it's cheapest API calls one.
    try {
      for (int i = 0; i < questionsToUpload; i++) {
        Question questionToUpload = await questions.getQuestion(
          QuestionType.topRatingQuestion,
          gameLevel!,
        );

        await cache.cacheItem(questionToUpload);
      }

      return true;
    } catch (e) {
      print("DownloadResult.connectionError");
      print(e);

      return false;
    }
  }
}

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadState());

  @override
  Stream<DownloadState> mapEventToState(DownloadEvent event) async* {
    switch (event) {
      case DownloadEvent.updateQuestions:
        NavigationManager.navigatorKey.currentState!
            .pushNamed("/loading_screen");

        await state.updateQuestions();
        await UtilityManager().sleep(seconds: 5);

        NavigationManager.popScreen();
        break;
      case DownloadEvent.removePreviousQuestions:
        state.removePreviousChange();
        break;
      case DownloadEvent.changeUploadQuestions:
        state.questionsToUploadChange();
        break;
      case DownloadEvent.download:
        NavigationManager.navigatorKey.currentState!
            .pushNamed("/loading_screen");

        await UtilityManager().sleep(seconds: 5);
        bool result = await state.downloadQuestions();

        if (!result) {
          NavigationManager.navigatorKey.currentState!
              .pushNamed("/no_internet_screen");
        } else {
          NavigationManager.pushNamed("/greetings_screen", {"text": "Success"});
        }

        state.version++;
        break;
    }

    yield DownloadState(
      questionsAvailable: state.questionsAvailable,
      questionsUsed: state.questionsUsed,
      questionsToUpload: state.questionsToUpload,
      removePrevious: state.removePrevious,
      gameLevel: state.gameLevel,
    );
  }
}
