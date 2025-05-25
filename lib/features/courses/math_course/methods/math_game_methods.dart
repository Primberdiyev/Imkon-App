class FixedMathGameController {
  final List<List<String>> _questions = [
    ['+3', '-1', '+5', '-2', '+1'],
    ['+10', '-4', '+6', '-2', '+5'],
    ['+20', '-5', '+12', '-4', '+1'],
  ];

  final List<int> _answers = [6, 15, 24];

  int currentExampleIndex = 0;
  List<String> get currentExample => _questions[currentExampleIndex];
  int getCorrectAnswer() => _answers[currentExampleIndex];

  void nextExample() {
    if (currentExampleIndex < _questions.length - 1) {
      currentExampleIndex++;
    }
  }

  void reset() {
    currentExampleIndex = 0;
  }

  bool checkUserAnswer(String input) {
    int userAnswer = int.tryParse(input.trim()) ?? 0;
    return userAnswer == getCorrectAnswer();
  }
}
