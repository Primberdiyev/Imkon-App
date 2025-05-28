import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/providers/multiplication_provider.dart';

class GameStartedPage extends StatelessWidget {
  const GameStartedPage({
    super.key,
    required this.question,
    required this.isAnswerChecked,
    required this.isAnswerCorrect,
    required this.controller,
  });

  final String question;
  final bool isAnswerChecked;
  final bool? isAnswerCorrect;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MultiplicationProvider>(
      context,
      listen: false,
    );

    void _submitAnswer() {
      if (controller.text.isNotEmpty) {
        provider.updateAnswer(controller.text);
        provider.checkAnswer(context);
        controller.clear();
      }
    }

    void _nextQuestion() {
      provider.nextQuestion(context);
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Javobni kiriting',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 30),
          if (!isAnswerChecked)
            TextButton(
              onPressed: _submitAnswer,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Tekshirish',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'myFirstFont',
                ),
              ),
            ),
          if (isAnswerChecked) ...[
            Text(
              isAnswerCorrect!
                  ? '✅ Tabriklayman!, Sizning javobingiz To\'g\'ri'
                  : 'Afsuski sizning javobingiz notog\'ri',
              style: TextStyle(
                color: isAnswerCorrect! ? Color(0xFF1BAC4B) : Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                elevation: 8,
                shadowColor: Colors.black,
              ),
              child: Text(
                provider.currentQuestionIndex == provider.questions.length - 1
                    ? 'Natijani ko‘rish'
                    : 'Keyingi',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'myFirstFont',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
