// part of 'multiplication_bloc.dart';

// @immutable
// abstract class MultiplicationState {}

// class MultiplicationInitial extends MultiplicationState {}

// class StartGameState extends MultiplicationState {
//   final String timer;

//   StartGameState({required this.timer});
// }

// class GameStarted extends MultiplicationState {
//   final int currentQuestionIndex;
//   final List<Map<String, dynamic>> questions;
//   final String userAnswer;
//   final bool? isAnswerCorrect;
//   final int correctCount;

//   GameStarted({
//     required this.currentQuestionIndex,
//     required this.questions,
//     required this.userAnswer,
//     required this.isAnswerCorrect,
//     required this.correctCount,
//   });

//   GameStarted copyWith({
//     int? currentQuestionIndex,
//     List<Map<String, dynamic>>? questions,
//     String? userAnswer,
//     bool? isAnswerCorrect,
//     int? correctCount,
//   }) {
//     return GameStarted(
//       currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
//       questions: questions ?? this.questions,
//       userAnswer: userAnswer ?? this.userAnswer,
//       isAnswerCorrect: isAnswerCorrect,
//       correctCount: correctCount ?? this.correctCount,
//     );
//   }
// }

// class GameFinished extends MultiplicationState {
//   final int correctCount;
//   final int totalQuestions;

//   GameFinished({required this.correctCount, required this.totalQuestions});
// }
