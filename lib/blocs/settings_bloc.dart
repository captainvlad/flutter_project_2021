import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/questions_cache_manager.dart';

enum SettingsEvent {
  toggleSound,
  toggleTime,
  updateDownloadedQuestions,
}

class SettingsState extends Equatable {
  int version = 0;
  String soundValue;
  int defaultTimeValue;
  int downloadedQuestions;

  QuestionsCacheManager cache = QuestionsCacheManager();

  @override
  List<Object?> get props => [
        version,
        soundValue,
        defaultTimeValue,
      ];

  SettingsState({
    this.soundValue = 'off',
    this.defaultTimeValue = 1,
    this.downloadedQuestions = -1,
  });

  Future updateDownloadedQuestions() async {
    dynamic rows = await cache.getAllQuestions();
    downloadedQuestions = rows.length;
    version++;
  }

  void toggleSound() {
    soundValue = soundValue == 'on' ? 'off' : 'on';
    version++;
  }

  void toggleTime() {
    switch (defaultTimeValue) {
      case 1:
        defaultTimeValue = 2;
        break;
      case 2:
        defaultTimeValue = 5;
        break;
      case 5:
        defaultTimeValue = 1;
        break;
    }
    version++;
  }
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    switch (event) {
      case SettingsEvent.toggleSound:
        state.toggleSound();
        break;
      case SettingsEvent.toggleTime:
        state.toggleTime();
        break;
      case SettingsEvent.updateDownloadedQuestions:
        await state.updateDownloadedQuestions();
        break;
    }

    yield SettingsState(
      soundValue: state.soundValue,
      defaultTimeValue: state.defaultTimeValue,
      downloadedQuestions: state.downloadedQuestions,
    );
  }
}
