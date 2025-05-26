import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class GuessNumberGame extends StatefulWidget {
  const GuessNumberGame({super.key});

  @override
  State<GuessNumberGame> createState() => _GuessNumberGameState();
}

class _GuessNumberGameState extends State<GuessNumberGame> {
  final TextEditingController _guessController = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  late int _targetNumber;
  int _countdown = 5;
  bool _isGameStarted = false;
  String _feedback = '';
  int _attempts = 0;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdown = 5;
    _feedback = '';
    _guessController.clear();
    _attempts = 0;
    _isGameStarted = false;

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--;
        } else {
          timer.cancel();
          _startGame();
        }
      });
    });
  }

  void _startGame() {
    final random = Random();
    _targetNumber = random.nextInt(100) + 1;
    _isGameStarted = true;
    _feedback = '1 dan 100 gacha son o\'yladim. Topishga harakat qiling!';
    audioPlayer.play(AssetSource('musics/guess_thought.mp3'));
    _guessController.clear();
    _attempts = 0;
  }

  void _checkGuess() {
    if (_guessController.text.trim().isEmpty) return;

    int? guess = int.tryParse(_guessController.text.trim());
    if (guess == null || guess < 1 || guess > 100) {
      setState(() {
        _feedback = 'Iltimos, 1 dan 100 gacha son kiriting.';
      });
      return;
    }

    setState(() {
      _attempts++;
      if (guess == _targetNumber) {
        _feedback =
            '🎉 Tabriklaymiz! $_attempts ta urinishda topdingiz!\n\nYana o\'ynaysizmi?';
        audioPlayer.play(AssetSource('musics/number_found.mp3'));

        _isGameStarted = false;
      } else if (guess > _targetNumber) {
        audioPlayer.play(AssetSource('musics/number_smaller.mp3'));

        _feedback = 'Men o\'ylagan son bundan kichikroq 🤏';
      } else {
        _feedback = 'Men o\'ylagan son bundan kattaroq 📈';
        audioPlayer.play(AssetSource('musics/number_bigger.mp3'));
      }
    });

    _guessController.clear();
  }

  void _restartGame() {
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _guessController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text(
          'Son Topish O\'yini',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/math_fon.jpg',
            ), // optional fon rasmi
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                _isGameStarted
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _feedback,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _guessController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Son kiriting',
                          ),
                          onSubmitted: (_) => _checkGuess(),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: _checkGuess,

                          child: const Text(
                            'Tekshirish',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Urinishlar: $_attempts',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_feedback.contains('Tabriklaymiz'))
                          Column(
                            children: [
                              const Text(
                                "O'yin boshlanishiga qoldi:",
                                style: TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '$_countdown',
                                style: const TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        if (_feedback.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                _feedback,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              TextButton(
                                onPressed: _restartGame,
                                style: TextButton.styleFrom(
                                  fixedSize: Size(150, 50),
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  'Yana o\'ynash',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'myFirstFont',
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
