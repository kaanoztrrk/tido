import 'dart:async';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class PomodoroService extends ChangeNotifier {
  Timer? timer;
  String currentState = "Focus";
  double currentDuration = 10;
  double selectedTime = 10;
  bool timerPlaying = false;
  int rounds = 0;
  VoidCallback? onPomodoroCompleted;

  AudioPlayer audioPlayer = AudioPlayer();

  void start() {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextRound();
        playNotificationSound();
        if (onPomodoroCompleted != null) {
          onPomodoroCompleted!();
        }
      } else {
        currentDuration--;
        notifyListeners();
      }
    });
  }

  void pause() {
    timer?.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void restart() {
    timer?.cancel();
    currentDuration = selectedTime;
    rounds = 0;
    currentState = "Focus";
    timerPlaying = false;
    notifyListeners();
  }

  void selectTime(double seconds) {
    selectedTime = seconds;
    currentDuration = seconds;
    notifyListeners();
  }

  void handleNextRound() {
    if (currentState == "Focus" && rounds < 3) {
      currentState = "Break";
      currentDuration = 5;
      selectedTime = 5;
      rounds++;
    } else if (currentState == "Break") {
      currentState = "Focus";
      currentDuration = 10;
      selectedTime = 10;
    } else if (currentState == "Focus" && rounds == 3) {
      currentState = "Long Break";
      currentDuration = 10;
      selectedTime = 10;
      rounds++;
    } else if (currentState == "Long Break") {
      currentState = "Focus";
      currentDuration = 10;
      selectedTime = 10;
      rounds = 0;
      pause();
    }

    notifyListeners();
  }

  void playNotificationSound() async {
    try {
      await audioPlayer.play(AssetSource('sounds/sounds.mp3'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }
}
