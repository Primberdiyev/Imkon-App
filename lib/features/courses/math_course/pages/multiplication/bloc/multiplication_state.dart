part of 'multiplication_bloc.dart';

@immutable
abstract class MultiplicationState {}

class MultiplicationInitial extends MultiplicationState {}

class StartGameState extends MultiplicationState {
  final String timer;
  StartGameState({required this.timer});
}

class GameStarted extends MultiplicationState {
  GameStarted();
}
