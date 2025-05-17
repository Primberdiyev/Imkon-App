import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'multiplication_event.dart';
part 'multiplication_state.dart';

class MultiplicationBloc
    extends Bloc<MultiplicationEvent, MultiplicationState> {
  MultiplicationBloc() : super(MultiplicationInitial()) {
    on<StartGameEvent>(_onStartGame);
  }
  Timer? _timer;

  Future<void> _onStartGame(
    StartGameEvent event,
    Emitter<MultiplicationState> emit,
  ) async {
    int seconds = 5;

    while (seconds > 0) {
      emit(StartGameState(timer: seconds.toString()));
      await Future.delayed(Duration(seconds: 1));
      seconds--;
    }

    emit(GameStarted());
  }
}
