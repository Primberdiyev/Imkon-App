import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/bloc/multiplication_bloc.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/finished_game.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/game_started.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/widgets/second_to_game.dart';

class MultiplicationPage extends StatefulWidget {
  const MultiplicationPage({super.key});

  @override
  State<MultiplicationPage> createState() => _MultiplicationPageState();
}

class _MultiplicationPageState extends State<MultiplicationPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MultiplicationBloc>().add(StartGameEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/math_fon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<MultiplicationBloc, MultiplicationState>(
          builder: (context, state) {
            if (state is StartGameState) {
              return SecondToGame(state: state);
            } else if (state is GameStarted) {
              return GameStartedPage(state: state, controller: _controller);
            } else if (state is GameFinished) {
              return FinishedGame(state: state);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
