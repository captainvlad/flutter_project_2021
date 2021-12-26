import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/general_models/question.dart';
import 'package:sequel/managers/questions_cache_manager.dart';
import 'package:sequel/managers/questions_manager.dart';

enum DownloadEvent {
  download,
  changeUploadQuestions,
  removePreviousQuestions,
  updateQuestions,
}

enum DownloadResult {
  raw,
  none,
  progress,
  connectionError,
  memoryError,
  otherError,
  success,
}

class DownloadState extends Equatable {
  int version;
  int questionsAvailable;
  int questionsUsed;
  int questionsToUpload;
  bool removePrevious;
  DownloadResult downloadResult;

  QuestionsCacheManager cache = QuestionsCacheManager();
  QuestionsManager questions = QuestionsManager();

  DownloadState({
    this.version = 0,
    this.questionsAvailable = -1,
    this.questionsUsed = -1,
    this.questionsToUpload = 10,
    this.removePrevious = false,
    this.downloadResult = DownloadResult.raw,
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
    downloadResult = DownloadResult.none;
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

  Future<DownloadResult> downloadQuestions() async {
    version++;

    if (removePrevious) {
      await cache.removeAllQuestions();
    }

    // QuestionType.topRatingQuestion is default as
    // it's cheapest API calls one.
    try {
      for (int i = 0; i < questionsToUpload; i++) {
        // Question questionToUpload = await questions.getQuestion(
        // QuestionType.topRatingQuestion,
        // );
        // cache.cacheItem(questionToUpload);
      }

      return DownloadResult.success;
    } on HttpException catch (e) {
      return DownloadResult.connectionError;
    } catch (e) {
      return DownloadResult.otherError;
    }
  }
}

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadState());

  @override
  Stream<DownloadState> mapEventToState(DownloadEvent event) async* {
    switch (event) {
      case DownloadEvent.updateQuestions:
        await state.updateQuestions();
        break;
      case DownloadEvent.removePreviousQuestions:
        state.removePreviousChange();
        break;
      case DownloadEvent.changeUploadQuestions:
        state.questionsToUploadChange();
        break;
      case DownloadEvent.download:
        state.version++;

        yield DownloadState(
          questionsAvailable: state.questionsAvailable,
          questionsUsed: state.questionsUsed,
          questionsToUpload: state.questionsToUpload,
          removePrevious: state.removePrevious,
          downloadResult: DownloadResult.progress,
        );

        DownloadResult result = await state.downloadQuestions();
        await Future.delayed(const Duration(seconds: 5));
        state.version++;

        yield DownloadState(
          questionsAvailable: state.questionsAvailable,
          questionsUsed: state.questionsUsed,
          questionsToUpload: state.questionsToUpload,
          removePrevious: state.removePrevious,
          downloadResult: result,
        );

        await Future.delayed(const Duration(seconds: 5));
        state.version++;

        yield DownloadState(
          questionsAvailable: state.questionsAvailable,
          questionsUsed: state.questionsUsed,
          questionsToUpload: state.questionsToUpload,
          removePrevious: state.removePrevious,
          downloadResult: DownloadResult.none,
        );
        break;
    }

    yield DownloadState(
      questionsAvailable: state.questionsAvailable,
      questionsUsed: state.questionsUsed,
      questionsToUpload: state.questionsToUpload,
      removePrevious: state.removePrevious,
      downloadResult: state.downloadResult,
    );
  }
}
