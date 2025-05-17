import 'package:flutter/material.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/bloc/multiplication_bloc.dart';

class SecondToGame extends StatelessWidget {
  const SecondToGame({super.key, required this.state});
  final StartGameState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textAlign: TextAlign.center,
        'O\'yin boshlanishiga qoldi:\n${state.timer}',
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          shadows: [
            Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1)),
          ],
        ),
      ),
    );
  }
}
