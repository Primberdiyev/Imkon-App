// import 'dart:math';

// class MultiplicationGameController {
//   List<int> numbers = [];

//   void generateQuestions() {
//     numbers.clear();
//     Random random = Random();
//     for (int i = 0; i < 4; i++) {
//       numbers.add(random.nextInt(9) + 1);
//     }
//   }

//   int getCorrectAnswer() {
//     return numbers.fold(1, (prod, val) => prod * val);
//   }

//   bool checkUserAnswer(String input) {
//     int userAnswer = int.tryParse(input.trim()) ?? 0;
//     return userAnswer == getCorrectAnswer();
//   }
// }
