import 'package:flutter/material.dart';
import 'package:imkon/features/cources/math_cource/pages/math_game_beginner.dart';

class AttentionDialog extends StatelessWidget {
  const AttentionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '🧠 Diqqat!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      content: Text(
        'Sizga random sonlar beriladi va siz ularni tezkorlik bilan hisoblashingiz kerak.\n\nO‘yin boshlaymizmi?',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MathGameBeginner()),
                );
              },
              child: Text('Boshlash', style: TextStyle()),
            ),
          ],
        ),
      ],
    );
  }
}
