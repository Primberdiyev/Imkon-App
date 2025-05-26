import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imkon/features/courses/math_course/methods/math_game_methods.dart';

class FixedMathGamePage extends StatefulWidget {
  const FixedMathGamePage({super.key});

  @override
  State<FixedMathGamePage> createState() => _FixedMathGamePageState();
}

class _FixedMathGamePageState extends State<FixedMathGamePage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int countdown = 5;
  int questionIndex = 0;
  int currentNumberIndex = 0;
  int questionCountdown = 5;
  Timer? countdownTimer;
  Timer? questionTimer;
  bool isGameStarted = false;
  bool isAnswering = false;
  TextEditingController answerController = TextEditingController();
  late FixedMathGameController controller;
  late AnimationController _animationController;
  String currentDisplayNumber = '';

  void initState() {
    super.initState();
    controller = FixedMathGameController();
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

  Future<void> _playNumberSound(String number) async {
    await _audioPlayer.play(AssetSource('musics/$number.mp3'));
  }

  void startGame() {
    setState(() {
      isGameStarted = true;
      currentNumberIndex = 0;
      questionCountdown = 5;
    });
    showNextQuestion();
  }

  void showNextQuestion() async {
    final questions = controller.currentExample;

    if (questionIndex < questions.length) {
      _animationController.forward(from: 0);

      for (var i = 0; i < questions.length; i++) {
        questionCountdown = 5;
        questionTimer?.cancel();

        questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!mounted) return;
          setState(() {
            if (questionCountdown > 0) {
              questionCountdown--;
            } else {
              timer.cancel();
            }
          });
        });

        if (!mounted) return;
        setState(() {
          currentDisplayNumber = questions[i];
          currentNumberIndex = i;
        });

        await _playNumberSound(
          questions[i].replaceAll('+', '').replaceAll('-', '-'),
        );

        await Future.delayed(const Duration(seconds: 5));
        if (!mounted) return;
      }

      questionTimer?.cancel();
      if (!mounted) return;
      setState(() {
        currentDisplayNumber = '';
        isAnswering = true;
      });

      await _audioPlayer.play(AssetSource('musics/javob_ayting.mp3'));
    }
  }

  void checkAnswer() async {
    if (answerController.text.trim().isEmpty) return;
    bool isCorrect = controller.checkUserAnswer(answerController.text);
    int correct = controller.getCorrectAnswer();
    int userAnswer = int.tryParse(answerController.text.trim()) ?? 0;

    // Play correct/incorrect sound
    await _audioPlayer.play(
      AssetSource(isCorrect ? 'musics/togri.mp3' : 'musics/notogri.mp3'),
    );

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
                      controller.nextExample();
                      restartGame();
                    },
                    child: const Text(
                      'Davom etish',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  void restartGame() {
    setState(() {
      countdown = 5;
      questionIndex = 0;
      currentNumberIndex = 0;
      currentDisplayNumber = '';
      answerController.clear();
      isGameStarted = false;
      isAnswering = false;
      questionCountdown = 5;
    });
    questionTimer?.cancel();
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                            if (!isAnswering)
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
                                      currentDisplayNumber,
                                      style: const TextStyle(
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '${currentNumberIndex + 1}/${controller.currentExample.length}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '⏱ Vaqt: $questionCountdown',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            else
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      fixedSize: Size(120, 60),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: checkAnswer,
                                    child: const Text(
                                      'Tekshirish',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
