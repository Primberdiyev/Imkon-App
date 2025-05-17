import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imkon/features/courses/math_course/methods/math_game_methods.dart';

class MathGameBeginner extends StatefulWidget {
  const MathGameBeginner({super.key});

  @override
  State<MathGameBeginner> createState() => _MathGameBeginnerState();
}

class _MathGameBeginnerState extends State<MathGameBeginner>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int countdown = 5;
  int questionCountdown = 5;
  int questionIndex = 0;
  Timer? countdownTimer;
  Timer? questionTimer;
  bool isGameStarted = false;
  bool isAnswering = false;
  TextEditingController answerController = TextEditingController();
  late AnimationController _animationController;
  late MathGameController controller;

  @override
  void initState() {
    super.initState();
    controller = MathGameController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          startGame();
        }
      });
    });
  }

  void startGame() {
    controller.generateQuestions();
    isGameStarted = true;
    showNextQuestion();
  }

  void showNextQuestion() {
    if (questionIndex < controller.questions.length) {
      questionCountdown = 5;
      _animationController.forward(from: 0);

      questionTimer?.cancel();
      questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          questionCountdown--;
          if (questionCountdown == 0) {
            timer.cancel();
            questionIndex++;
            showNextQuestion();
          }
        });
      });
    } else {
      isAnswering = true;
      setState(() {});
    }
  }

  void checkAnswer() async {
    if (answerController.text.trim().isEmpty) return;
    bool isCorrect = controller.checkUserAnswer(answerController.text);
    int correct = controller.getCorrectAnswer();
    int userAnswer = int.tryParse(answerController.text.trim()) ?? 0;

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Center(
              child: Text(
                isCorrect ? '✅ Barakalla!' : '❌ Notog‘ri!',
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('To‘g‘ri javob: $correct'),
                Text('Sizning javobingiz: $userAnswer'),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Bosh Sahifa'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      if (isCorrect) {
                        controller.increaseDifficulty();
                        restartGame();
                      } else {
                        controller.resetDifficulty();
                        restartGame(reset: true);
                      }
                    },
                    child: const Text(
                      'Davom etish',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'myFirstFont',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
    if (isCorrect) {
      if (isCorrect) {
        await _audioPlayer.play(AssetSource('musics/success1.mp3'));
      }
    }
  }

  void restartGame({bool reset = false}) {
    setState(() {
      countdown = 5;
      questionIndex = 0;
      answerController.clear();
      isGameStarted = false;
      isAnswering = false;
    });
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    questionTimer?.cancel();
    answerController.dispose();
    _animationController.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/math_fon.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    isGameStarted
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (questionIndex < controller.questions.length)
                              Column(
                                children: [
                                  ScaleTransition(
                                    scale: Tween(begin: 0.5, end: 1.0).animate(
                                      CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.elasticOut,
                                      ),
                                    ),
                                    child: Text(
                                      controller.questions[questionIndex],
                                      style: const TextStyle(
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '⏱ Vaqt: $questionCountdown',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            else if (isAnswering)
                              Column(
                                children: [
                                  const Text(
                                    'Natijani kiriting:',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: answerController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Javobingiz',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: checkAnswer,
                                    child: const Text('Tekshirish'),
                                  ),
                                ],
                              ),
                          ],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "O'yin boshlanishiga qoldi:",
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '$countdown',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ),
          Positioned(top: 60, left: 10, child: BackButton(color: Colors.black)),
        ],
      ),
    );
  }
}
