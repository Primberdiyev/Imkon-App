import 'dart:math';

class MathGameController {
  int difficulty;
  List<String> questions = [];
  List<int> answers = [];

  MathGameController({this.difficulty = 10});

  void generateQuestions() {
    questions.clear();
    answers.clear();
    Random random = Random();
    int result = 0;

    for (int i = 0; i < 5; i++) {
      int value = random.nextInt(difficulty);
      bool isPlus = i % 2 == 0;
      int signedValue = isPlus ? value : -value;
      questions.add("${isPlus ? '+' : '-'}$value");
      answers.add(signedValue);
      result += signedValue;
    }
  }

  int getCorrectAnswer() {
    return answers.fold(0, (sum, val) => sum + val);
  }

  bool checkUserAnswer(String userInput) {
    int userAnswer = int.tryParse(userInput.trim()) ?? 0;
    return userAnswer == getCorrectAnswer();
  }

  void increaseDifficulty() {
    difficulty = min(100, difficulty + 10);
  }

  void resetDifficulty() {
    difficulty = 10;
  }
}
