import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/providers/multiplication_provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/dialogs/confirm_dialog.dart';

class FinishedGame extends StatelessWidget {
  const FinishedGame({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MultiplicationProvider>(context);
    final correctCount = provider.correctCount;
    final totalQuestions = provider.questions.length;

    void _onExitPressed() async {
      final exit = await showDialog<bool>(
        context: context,
        builder: (_) => ConfirmExitDialog(),
      );
      if (exit ?? false) {
        Navigator.of(context).pop();
      }
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'O\'yin yakunlandi!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'To‘g‘ri javoblar: $correctCount / $totalQuestions',
            style: TextStyle(fontSize: 26, color: Colors.blue),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: _onExitPressed,
            child: Text('Bosh sahifaga', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              elevation: 8,
              shadowColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
