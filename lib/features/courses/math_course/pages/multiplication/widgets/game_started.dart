import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/bloc/multiplication_bloc.dart';

class GameStartedPage extends StatefulWidget {
  const GameStartedPage({
    super.key,
    required this.state,
    required this.controller,
  });
  final GameStarted state;
  final TextEditingController controller;

  @override
  State<GameStartedPage> createState() => _GameStartedPageState();
}

class _GameStartedPageState extends State<GameStartedPage> {
  void _submitAnswer() {
    final answer = widget.controller.text;
    if (answer.isNotEmpty) {
      context.read<MultiplicationBloc>().add(AnswerSubmittedEvent(answer));
    }
  }

  void _nextQuestion() {
    widget.controller.clear();
    context.read<MultiplicationBloc>().add(NextQuestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    final question =
        widget.state.questions[widget.state.currentQuestionIndex]['question'];
    final isCorrect = widget.state.isAnswerCorrect;
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
            controller: widget.controller,
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
          TextButton(
            onPressed: (isCorrect == null) ? _submitAnswer : null,
            style: TextButton.styleFrom(
              backgroundColor: (isCorrect == null) ? Colors.blue : Colors.grey,
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
          const SizedBox(height: 10),
          if (isCorrect != null)
            Text(
              isCorrect ? 'Barakalla!' : 'Xato!',
              style: TextStyle(
                color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 1,
                    color: Colors.black54,
                    offset: Offset(1, 0),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          if (isCorrect != null)
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
                widget.state.currentQuestionIndex ==
                        widget.state.questions.length - 1
                    ? 'Natijani ko‘rish'
                    : 'Keyingi',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'myFirstFont',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
