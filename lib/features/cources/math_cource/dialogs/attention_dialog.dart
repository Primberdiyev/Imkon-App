import 'package:flutter/material.dart';

class AttentionDialog extends StatelessWidget {
  const AttentionDialog({
    super.key,
    required this.text,
    required this.function,
  });
  final String text;
  final Function() function;

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
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: function,
              child: Text('Boshlash', style: TextStyle()),
            ),
          ],
        ),
      ],
    );
  }
}
