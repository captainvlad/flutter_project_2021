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
    this.gameMode = button_6,
    this.gameType = button_5,
    this.level = button_7,
    this.multiplayer = button_8,
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
    gameType = gameType == button_5 ? button_5_1 : button_5;
    version++;
  }

  void toggleGameMode() {
    switch (gameMode) {
      case button_6:
        gameMode = button_6_1;
        break;
      case button_6_1:
        gameMode = button_6_2;
        break;
      case button_6_2:
        gameMode = button_6_3;
        break;
      case button_6_3:
        gameMode = button_6_4;
        break;
      case button_6_4:
        gameMode = button_6;
        break;
    }

    version++;
  }

  void toggleLevel() {
    level = level == button_7 ? button_7_1 : button_7;
    version++;
  }

  void toggleMultiplayer() {
    multiplayer = multiplayer == button_8 ? button_8_1 : button_8;
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
