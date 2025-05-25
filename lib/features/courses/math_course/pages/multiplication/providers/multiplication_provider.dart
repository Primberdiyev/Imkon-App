// MultiplicationProvider.dart
import 'package:flutter/material.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/services/audio_service.dart';
import 'package:provider/provider.dart';

class MultiplicationProvider with ChangeNotifier {
  final List<Map<String, dynamic>> questions = [
    {'question': '2 * 3 = ?', 'answer': 6},
    {'question': '4 * 2 = ?', 'answer': 8},
    {'question': '5 * 5 = ?', 'answer': 25},
    {'question': '3 * 4 = ?', 'answer': 12},
    {'question': '5 * 2 = ?', 'answer': 10},
  ];

  int _currentQuestionIndex = 0;
  String _userAnswer = '';
  bool? _isAnswerCorrect;
  int _correctCount = 0;
  int _countdown = 5;
  bool _isGameStarted = false;
  bool _isGameFinished = false;
  bool _isAnswerChecked = false;

  int get currentQuestionIndex => _currentQuestionIndex;
  String get userAnswer => _userAnswer;
  bool? get isAnswerCorrect => _isAnswerCorrect;
  int get correctCount => _correctCount;
  int get countdown => _countdown;
  bool get isGameStarted => _isGameStarted;
  bool get isGameFinished => _isGameFinished;
  bool get isAnswerChecked => _isAnswerChecked;
  String get currentQuestion => questions[_currentQuestionIndex]['question'];

  // O'yinni reset qilish
  void resetGame() {
    _currentQuestionIndex = 0;
    _userAnswer = '';
    _isAnswerCorrect = null;
    _correctCount = 0;
    _countdown = 5;
    _isGameStarted = false;
    _isGameFinished = false;
    _isAnswerChecked = false;
    notifyListeners();
  }

  // Countdown boshlash
  Future<void> startCountdown(BuildContext context) async {
    final audioService = Provider.of<AudioService>(context, listen: false);

    for (_countdown = 5; _countdown > 0; _countdown--) {
      notifyListeners();
      await Future.delayed(Duration(seconds: 1));
    }

    _isGameStarted = true;
    await audioService.playQuestionAudio(_currentQuestionIndex);
    notifyListeners();
  }

  // multiplication_provider.dart
  void checkAnswer(BuildContext context) async {
    final audioService = Provider.of<AudioService>(context, listen: false);
    final correctAnswer = questions[_currentQuestionIndex]['answer'].toString();
    _isAnswerCorrect = _userAnswer.trim() == correctAnswer;
    _isAnswerChecked = true;

    if (_isAnswerCorrect!) {
      _correctCount++;
      await audioService.playCorrectAnswerSound();
    } else {
      await audioService
          .playWrongAnswerSound(); 
    }

    notifyListeners();
  }

  Future<void> nextQuestion(BuildContext context) async {
    final audioService = Provider.of<AudioService>(context, listen: false);

    _userAnswer = '';
    _isAnswerCorrect = null;
    _isAnswerChecked = false;

    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
      await audioService.playQuestionAudio(_currentQuestionIndex);
    } else {
      _isGameFinished = true;
      await audioService.playFinishAudio();
    }

    notifyListeners();
  }

  void updateAnswer(String answer) {
    _userAnswer = answer;
    notifyListeners();
  }
}
