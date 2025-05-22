import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MathGameAdvanced extends StatefulWidget {
  const MathGameAdvanced({super.key});

  @override
  State<MathGameAdvanced> createState() => _MathGameAdvancedState();
}

class _MathGameAdvancedState extends State<MathGameAdvanced>
    with SingleTickerProviderStateMixin {
  //final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _answerController = TextEditingController();
  final List<String> _questions = [];
  final List<int> _correctAnswers = [];
  int _currentQuestionIndex = 0;
  int _questionCountdown = 5;
  int _countdown = 5;
  int _score = 0;
  bool _isGameStarted = false;
  bool _isTimerQuestions = false;
  bool _isInitialQuestionsDone = false;
  Timer? _countdownTimer;
  Timer? _questionTimer;
  late AnimationController _animationController;

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
    _questions.addAll(['4+5*6', '(2+3)*2-1', '8*3+2', '10-3*2', '5+6*2-4']);
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

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _isGameStarted = true;
        }
      });
    });
  }

  void _startTimerQuestions() {
    _isTimerQuestions = true;
    _questions.clear();
    _correctAnswers.clear();
    _currentQuestionIndex = 0;
    _generateTimerQuestions();
    _showNextTimerQuestion();
  }

  void _generateTimerQuestions() {
    _questions.addAll(['3+2*2', '(4+1)*3', '12-2*4', '7+8-2*3', '(6+2)*(3-1)']);
    for (var q in _questions) {
      _correctAnswers.add(_evaluateExpression(q));
    }
  }

  void _showNextTimerQuestion() {
    _answerController.clear();
    if (_currentQuestionIndex < _questions.length) {
      _questionCountdown = 10;
      _animationController.forward(from: 0);
      _questionTimer?.cancel();
      _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _questionCountdown--;
          if (_questionCountdown == 0) {
            timer.cancel();
            _currentQuestionIndex++;
            _showNextTimerQuestion();
          }
        });
      });
    } else {
      _isTimerQuestions = false;
      setState(() {});
    }
  }

  void _checkInitialAnswer() {
    int? userAnswer = int.tryParse(_answerController.text.trim());
    if (userAnswer != null &&
        userAnswer == _correctAnswers[_currentQuestionIndex]) {
      _score++;
    }

    _currentQuestionIndex++;
    _answerController.clear();

    if (_currentQuestionIndex >= _questions.length) {
      _isInitialQuestionsDone = true;
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
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
    } else {
      setState(() {});
    }
  }

  void _checkTimerAnswer() async {
    if (_answerController.text.trim().isEmpty) return;
    int? answer = int.tryParse(_answerController.text);
    if (answer == _correctAnswers[_currentQuestionIndex]) {
      //  await _audioPlayer.play(AssetSource('musics/success1.mp3'));
    }
    _questionTimer?.cancel();
    _currentQuestionIndex++;
    _showNextTimerQuestion();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _questionTimer?.cancel();
    _animationController.dispose();
    // _audioPlayer.dispose();
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
                child:
                    _isGameStarted
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
                                SizedBox(height: 20),
                                Text(
                                  'Notog‘ri javoblar: ${_correctAnswers.length - _score}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    fixedSize: Size(200, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
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
          Positioned(top: 60, left: 10, child: BackButton(color: Colors.black)),
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
        TextField(
          controller: _answerController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Javobingizni kiriting',
          ),
        ),

        const SizedBox(height: 50),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: Size(150, 50),
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
              TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Javobingiz',
                ),
                onSubmitted: (_) => _checkTimerAnswer(),
              ),
              const SizedBox(height: 30),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(150, 50),
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
