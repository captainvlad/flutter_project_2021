import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'navigation_manager.dart';

class UtilityManager {
  String audioTrack = "sounds/dont_let_me_be_misunderstood.mp3";

  void quitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Future<List<dynamic>> togglePlayer({
    required String soundValue,
    AudioCache? cache,
    AudioPlayer? player,
  }) async {
    if (soundValue == 'on') {
      if (player != null) {
        player.resume();
      } else {
        cache = AudioCache();
        player = await cache.play(audioTrack);

        player.onPlayerCompletion.listen(
          (event) {
            cache!.play(audioTrack);
          },
        );
      }
    } else {
      player!.pause();
    }

    return [cache, player];
  }

  Future<bool> popCallback() {
    NavigationManager.popToFirst();

    return Future(
      () => true,
    );
  }

  String formatTime(int currentTime) {
    String seconds;

    if (currentTime % 60 < 10) {
      seconds = "0${currentTime % 60}";
    } else {
      seconds = "${currentTime % 60}";
    }

    return "${currentTime ~/ 60}:$seconds";
  }

  void showToast({required String toastText}) {
    Fluttertoast.showToast(
      msg: toastText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  String generateMessage(List<String> achievementsNames) {
    if (achievementsNames.isEmpty) {
      return "";
    } else if (achievementsNames.length == 1) {
      return "Following achievement: ${achievementsNames[0]} was unlocked";
    }

    String result = "Following achievements: " +
        achievementsNames.join(", ") +
        " were unclocked";

    return result;
  }

  Future sleep({required int seconds}) {
    return Future.delayed(
      Duration(seconds: seconds),
    );
  }
}
