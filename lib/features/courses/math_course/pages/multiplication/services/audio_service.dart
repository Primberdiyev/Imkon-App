import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playQuestionAudio(int index) async {
    await _audioPlayer.play(AssetSource('musics/multip${index + 1}.mp3'));
  }

  Future<void> playFinishAudio() async {
    await _audioPlayer.play(AssetSource('musics/multip_finish.mp3'));
  }

  Future<void> playCorrectAnswerSound() async {
    await _audioPlayer.play(AssetSource('musics/togri.mp3'));
  }

  Future<void> playWrongAnswerSound() async {
    await _audioPlayer.play(AssetSource('musics/notogri.mp3'));
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }
}
