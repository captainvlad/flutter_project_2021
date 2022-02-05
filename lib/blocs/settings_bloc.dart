import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/managers/navigation_manager.dart';
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
  // Remove to utilities later AAADIP
  AudioPlayer? player;
  AudioCache? cache;

  QuestionsCacheManager cacheManager = QuestionsCacheManager();

  @override
  List<Object?> get props => [
        version,
        soundValue,
        defaultTimeValue,
      ];

  SettingsState({
    this.soundValue = 'off',
    this.defaultTimeValue = 1,
    this.downloadedQuestions = 0,
    this.player,
  });

  Future updateDownloadedQuestions() async {
    dynamic rows = await cacheManager.getAllQuestions();
    downloadedQuestions = rows.length;
    version++;
  }

  Future toggleSound() async {
    soundValue = soundValue == 'on' ? 'off' : 'on';
    version++;

    // Remove to utilities later AAADIP
    if (soundValue == 'on') {
      if (player != null) {
        player!.resume();
      } else {
        cache = AudioCache();
        player = await cache!.play("sounds/dont_let_me_be_misunderstood.mp3");

        player!.onPlayerCompletion.listen((event) {
          cache!.play("sounds/dont_let_me_be_misunderstood.mp3");
        });
      }
    } else {
      player!.pause();
    }
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
        await state.toggleSound();
        break;
      case SettingsEvent.toggleTime:
        state.toggleTime();
        break;
      case SettingsEvent.updateDownloadedQuestions:
        NavigationManager.navigatorKey.currentState!
            .pushNamed("/loading_screen");

        await state.updateDownloadedQuestions();
        await Future.delayed(const Duration(seconds: 5));

        NavigationManager.navigatorKey.currentState!.pop();
        break;
    }

    yield SettingsState(
      soundValue: state.soundValue,
      defaultTimeValue: state.defaultTimeValue,
      downloadedQuestions: state.downloadedQuestions,
      player: state.player,
    );
  }
}
