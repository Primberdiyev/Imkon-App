import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:audioplayers/audioplayers.dart';

class MathGameAdvanced extends StatefulWidget {
  const MathGameAdvanced({super.key});

  @override
  State<MathGameAdvanced> createState() => _MathGameAdvancedState();
}

class _MathGameAdvancedState extends State<MathGameAdvanced>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _answerController = TextEditingController();
  final List<String> _questions = [];
  final List<int> _correctAnswers = [];
  final List<String> _questionAudios = [];
  int _currentQuestionIndex = 0;
  int _questionCountdown = 5;
  int _countdown = 5;
  int _score = 0;
  bool _isGameStarted = false;
  bool _isTimerQuestions = false;
  bool _isInitialQuestionsDone = false;
  bool _isAnswerChecked = false;
  bool _isAnswerCorrect = false;
  Timer? _countdownTimer;
  Timer? _questionTimer;
  late AnimationController _animationController;
  bool _isAudioPlaying = false;
  StreamSubscription? _audioCompleteSubscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _generateInitialQuestions();
    _startCountdown();
  }

  void _generateInitialQuestions() {
    _questions.addAll(['4+5*6', '5*2-1', '8*3+2', '10-3*2', '5+6*2-4']);
    _questionAudios.addAll([
      'musics/adv0.mp3',
      'musics/adv1.mp3',
      'musics/adv2.mp3',
      'musics/adv3.mp3',
      'musics/adv4.mp3',
    ]);
    for (var q in _questions) {
      _correctAnswers.add(_evaluateExpression(q));
    }
  }

  int _evaluateExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    return result.toInt();
  }

  Future<void> _playQuestionAudio() async {
    if (_currentQuestionIndex >= _questionAudios.length) return;

    _audioCompleteSubscription?.cancel();

    try {
      setState(() {
        _isAudioPlaying = true;
      });

      await _audioPlayer.stop();

      await _audioPlayer.play(
        AssetSource(_questionAudios[_currentQuestionIndex]),
      );

      _audioCompleteSubscription = _audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          _isAudioPlaying = false;
        });
      });
    } catch (e) {
      setState(() {
        _isAudioPlaying = false;
      });
    }
  }

  Future<void> _stopCurrentAudio() async {
    try {
      await _audioPlayer.stop();
      _audioCompleteSubscription?.cancel();
      setState(() {
        _isAudioPlaying = false;
      });
    } catch (e) {}
  }

  Future<void> _playCorrectSound() async {
    await _stopCurrentAudio();
    await _audioPlayer.play(AssetSource('musics/togri.mp3'));
  }

  Future<void> _playWrongSound() async {
    await _stopCurrentAudio();
    await _audioPlayer.play(AssetSource('musics/notogri.mp3'));
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _isGameStarted = true;
          _playQuestionAudio();
        }
      });
    });
  }

  void _startTimerQuestions() {
    _isTimerQuestions = true;
    _questions.clear();
    _correctAnswers.clear();
    _questionAudios.clear();
    _currentQuestionIndex = 0;
    _generateTimerQuestions();
    _showNextTimerQuestion();
  }

  void _generateTimerQuestions() {
    _questions.addAll(['3+2*2', '5*3-1', '12-2*4', '8-2*3', '4*1+2']);
    _questionAudios.addAll([
      'musics/adv5.mp3',
      'musics/adv6.mp3',
      'musics/adv7.mp3',
      'musics/adv8.mp3',
      'musics/adv9.mp3',
    ]);
    for (var q in _questions) {
      _correctAnswers.add(_evaluateExpression(q));
    }
  }

  void _showNextTimerQuestion() async {
    await _stopCurrentAudio();

    setState(() {
      _answerController.clear();
      _isAnswerChecked = false;
      _isAnswerCorrect = false;
    });

    if (_currentQuestionIndex < _questions.length) {
      _questionCountdown = 15;
      _animationController.forward(from: 0);
      _playQuestionAudio();

      _questionTimer?.cancel();
      _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (!_isAudioPlaying) {
            _questionCountdown--;
          }

          if (_questionCountdown <= 0) {
            timer.cancel();
            _currentQuestionIndex++;
            if (_currentQuestionIndex < _questions.length) {
              _showNextTimerQuestion();
            } else {
              setState(() {
                _isTimerQuestions = false;
              });
            }
          }
        });
      });
    } else {
      _isTimerQuestions = false;
      setState(() {});
    }
  }

  Future<void> _checkInitialAnswer() async {
    int? userAnswer = int.tryParse(_answerController.text.trim());
    _isAnswerCorrect = userAnswer != null &&
        userAnswer == _correctAnswers[_currentQuestionIndex];

    if (_isAnswerCorrect) {
      _score++;
      await _playCorrectSound();
    } else {
      await _playWrongSound();
    }

    setState(() {
      _isAnswerChecked = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    _currentQuestionIndex++;
    _answerController.clear();

    if (_currentQuestionIndex >= _questions.length) {
      _isInitialQuestionsDone = true;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Natija'),
          content: Text(
            '$_score / ${_correctAnswers.length} to‘g‘ri javob',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                _startTimerQuestions();
              },
              child: const Text(
                'Keyingi bosqich',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {}
  }

  Future<void> _checkTimerAnswer() async {
    if (_answerController.text.trim().isEmpty) return;

    int? answer = int.tryParse(_answerController.text);
    _isAnswerCorrect = answer == _correctAnswers[_currentQuestionIndex];

    if (_isAnswerCorrect) {
      _score++;
      await _playCorrectSound();
    } else {
      await _playWrongSound();
    }

    setState(() {
      _isAnswerChecked = true;
    });
    _questionTimer?.cancel();

    await Future.delayed(const Duration(seconds: 4));

    _currentQuestionIndex++;
    _showNextTimerQuestion();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _questionTimer?.cancel();
    _animationController.dispose();
    _audioCompleteSubscription?.cancel();
    _audioPlayer.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
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
                child: _isGameStarted
                    ? _isTimerQuestions
                        ? _buildTimerQuestions()
                        : !_isInitialQuestionsDone
                            ? _buildInitialStepByStepQuestions()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'O‘yin tugadi!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'To‘g‘ri javoblar: $_score',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Notog‘ri javoblar: ${10 - _score}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      fixedSize: const Size(200, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Bosh sahifa',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                    : _buildCountdown(),
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 10,
            child: BackButton(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "O'yin boshlanishiga qoldi:",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        Text(
          '$_countdown',
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInitialStepByStepQuestions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Savol ${_currentQuestionIndex + 1}/${_questions.length}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        Text(
          _questions[_currentQuestionIndex],
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        if (!_isAnswerChecked)
          TextField(
            controller: _answerController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Javobingizni kiriting',
            ),
          ),
        const SizedBox(height: 20),
        if (_isAnswerChecked)
          Text(
            _isAnswerCorrect
                ? '✅ Tabriklayman! Sizning javobingiz To\'gri'
                : '❌ Noto‘g‘ri! To‘g‘ri javob: ${_correctAnswers[_currentQuestionIndex]}',
            style: TextStyle(
              fontSize: 18,
              color: _isAnswerCorrect ? Colors.green : Colors.red,
            ),
          ),
        const SizedBox(height: 20),
        if (!_isAnswerChecked)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              fixedSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: _checkInitialAnswer,
            child: const Text(
              'Tekshirish',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'myFirstFont',
                fontSize: 18,
              ),
            ),
          ),
        if (_isAnswerChecked)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              setState(() {
                _isAnswerChecked = false;
                _answerController.clear();
              });
              await _stopCurrentAudio();

              _playQuestionAudio();
            },
            child: const Text(
              'Keyingi',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'myFirstFont',
                fontSize: 18,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTimerQuestions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_currentQuestionIndex < _questions.length)
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
                  _questions[_currentQuestionIndex],
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '⏱ Vaqt: $_questionCountdown',
                style: const TextStyle(fontSize: 24, color: Colors.red),
              ),
              const SizedBox(height: 20),
              if (!_isAnswerChecked)
                TextField(
                  controller: _answerController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Javobingiz',
                  ),
                  onSubmitted: (_) => _checkTimerAnswer(),
                ),
              const SizedBox(height: 20),
              if (_isAnswerChecked)
                Text(
                  textAlign: TextAlign.center,
                  _isAnswerCorrect
                      ? '✅ Tabriklayman!, Sizning javobingiz To\'gri'
                      : '❌ Noto‘g‘ri! To‘g‘ri javob: ${_correctAnswers[_currentQuestionIndex]}',
                  style: TextStyle(
                    fontSize: 18,
                    color: _isAnswerChecked ? Colors.green : Colors.red,
                  ),
                ),
              const SizedBox(height: 30),
              if (!_isAnswerChecked)
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: _checkTimerAnswer,
                  child: const Text(
                    'Tekshirish',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'myFirstFont',
                      fontSize: 18,
                    ),
                  ),
                ),
              // if (_isAnswerChecked)
              //   TextButton(
              //     style: TextButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       fixedSize: const Size(150, 50),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //     ),
              //     onPressed: () async {
              //       await _stopCurrentAudio();
              //       _currentQuestionIndex++;
              //       _showNextTimerQuestion();
              //     },
              //     child: const Text(
              //       'Keyingi',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontFamily: 'myFirstFont',
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
            ],
          )
        else
          const Text(
            'O‘yin tugadi!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
