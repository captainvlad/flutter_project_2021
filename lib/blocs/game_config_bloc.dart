import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequel/res/values/strings.dart';

enum GameConfigEvent {
  toggleGameType,
  toggleGameMode,
  toggleLevel,
  toggleMultiplayer,
}

class GameConfigState extends Equatable {
  late int version;
  late String gameType;
  late String gameMode;
  late String level;
  late String multiplayer;

  GameConfigState({
    this.version = 0,
    this.gameMode = head_to_head,
    this.gameType = bullet,
    this.level = easy,
    this.multiplayer = off,
  });

  @override
  List<Object?> get props => [
        version,
        gameType,
        gameMode,
        level,
        multiplayer,
      ];

  void toggleGameType() {
    gameType = gameType == bullet ? classic : bullet;
    version++;
  }

  void toggleGameMode() {
    switch (gameMode) {
      case head_to_head:
        gameMode = guess_by_frame;
        break;
      case guess_by_frame:
        gameMode = guess_director;
        break;
      case guess_director:
        gameMode = guess_by_tag;
        break;
      case guess_by_tag:
        gameMode = find_the_odd;
        break;
      case find_the_odd:
        gameMode = head_to_head;
        break;
    }

    version++;
  }

  void toggleLevel() {
    level = level == easy ? hard : easy;
    version++;
  }

  void toggleMultiplayer() {
    multiplayer = multiplayer == off ? on : off;
    version++;
  }
}

class GameConfigBloc extends Bloc<GameConfigEvent, GameConfigState> {
  GameConfigBloc() : super(GameConfigState());

  @override
  Stream<GameConfigState> mapEventToState(GameConfigEvent event) async* {
    switch (event) {
      case GameConfigEvent.toggleGameMode:
        state.toggleGameMode();
        break;
      case GameConfigEvent.toggleGameType:
        state.toggleGameType();
        break;
      case GameConfigEvent.toggleLevel:
        state.toggleLevel();
        break;
      case GameConfigEvent.toggleMultiplayer:
        state.toggleMultiplayer();
        break;
    }

    yield GameConfigState(
      gameType: state.gameType,
      gameMode: state.gameMode,
      level: state.level,
      multiplayer: state.multiplayer,
    );
  }
}
