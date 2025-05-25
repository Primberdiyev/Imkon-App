// MultiplicationPage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/providers/multiplication_provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/finished_game.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/game_started.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/second_to_game.dart';

class MultiplicationPage extends StatefulWidget {
  const MultiplicationPage({super.key});

  @override
  State<MultiplicationPage> createState() => _MultiplicationPageState();
}

class _MultiplicationPageState extends State<MultiplicationPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<MultiplicationProvider>(
        context,
        listen: false,
      );
      provider.resetGame();
      Future.delayed(Duration.zero, () {
        provider.startCountdown(context);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MultiplicationProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/math_fon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: _buildContent(provider),
      ),
    );
  }

  Widget _buildContent(MultiplicationProvider provider) {
    if (!provider.isGameStarted) {
      return SecondToGame();
    } else if (provider.isGameFinished) {
      return FinishedGame();
    } else {
      return GameStartedPage(
        question: provider.currentQuestion,
        isAnswerChecked: provider.isAnswerChecked,
        isAnswerCorrect: provider.isAnswerCorrect,
        controller: _controller,
      );
    }
  }
}
