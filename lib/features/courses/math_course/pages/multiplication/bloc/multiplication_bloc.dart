// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'multiplication_event.dart';
// part 'multiplication_state.dart';

// class MultiplicationBloc
//     extends Bloc<MultiplicationEvent, MultiplicationState> {
//   final List<Map<String, dynamic>> questions = [
//     {
//       'question': '2 * 3 = ?',
//       'answer': 6,
//       'audio': 'assets/musics/multip1.mp3',
//     },
//     {'question': '4 * 2 = ?', 'answer': 8},
//     {'question': '5 * 5 = ?', 'answer': 25},
//     {'question': '3 * 4 = ?', 'answer': 12},
//     {'question': '5* 2 = ?', 'answer': 10},
//   ];

//   Timer? _timer;
//   int _countdown = 5;

//   MultiplicationBloc() : super(MultiplicationInitial()) {
//     on<StartGameEvent>(_onStartGame);
//     on<AnswerSubmittedEvent>(_onAnswerSubmitted);
//     on<NextQuestionEvent>(_onNextQuestion);
//   }

//   Future<void> _onStartGame(
//     StartGameEvent event,
//     Emitter<MultiplicationState> emit,
//   ) async {
//     _countdown = 5;

//     while (_countdown > 0) {
//       emit(StartGameState(timer: _countdown.toString()));
//       await Future.delayed(Duration(seconds: 1));
//       _countdown--;
//     }
//     _timer?.cancel();
//     emit(
//       GameStarted(
//         currentQuestionIndex: 0,
//         questions: questions,
//         userAnswer: '',
//         isAnswerCorrect: null,
//         correctCount: 0,
//       ),
//     );
//   }

//   void _onAnswerSubmitted(
//     AnswerSubmittedEvent event,
//     Emitter<MultiplicationState> emit,
//   ) {
//     if (state is GameStarted) {
//       final currentState = state as GameStarted;
//       final currentQ = questions[currentState.currentQuestionIndex];
//       final correctAnswer = currentQ['answer'].toString();

//       final isCorrect = event.answer.trim() == correctAnswer;

//       emit(
//         currentState.copyWith(
//           userAnswer: event.answer,
//           isAnswerCorrect: isCorrect,
//           correctCount:
//               isCorrect
//                   ? currentState.correctCount + 1
//                   : currentState.correctCount,
//         ),
//       );
//     }
//   }

//   void _onNextQuestion(
//     NextQuestionEvent event,
//     Emitter<MultiplicationState> emit,
//   ) {
//     if (state is GameStarted) {
//       final currentState = state as GameStarted;
//       final nextIndex = currentState.currentQuestionIndex + 1;

//       if (nextIndex < questions.length) {
//         emit(
//           GameStarted(
//             currentQuestionIndex: nextIndex,
//             questions: questions,
//             userAnswer: '',
//             isAnswerCorrect: null,
//             correctCount: currentState.correctCount,
//           ),
//         );
//       } else {
//         emit(
//           GameFinished(
//             correctCount: currentState.correctCount,
//             totalQuestions: questions.length,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Future<void> close() {
//     _timer?.cancel();
//     return super.close();
//   }
// }
