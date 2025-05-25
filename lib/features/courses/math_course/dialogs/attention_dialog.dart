import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AttentionDialog extends StatelessWidget {
  const AttentionDialog({
    super.key,
    required this.text,
    required this.function,
    this.startSound,
    this.audioPlayer,
  });

  final String text;
  final Function() function;
  final String? startSound;
  final AudioPlayer? audioPlayer;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '🧠 Diqqat!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      content: Text(text, style: TextStyle(fontSize: 18, color: Colors.black)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (audioPlayer != null) {
                  audioPlayer?.stop();
                }
              },
              child: Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () async {
                if (startSound != null) {
                  final audioPlayer = AudioPlayer();
                  await audioPlayer.play(AssetSource(startSound ?? ""));
                }
                if (audioPlayer != null) {
                  audioPlayer?.stop();
                }
                function();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Boshlash',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
