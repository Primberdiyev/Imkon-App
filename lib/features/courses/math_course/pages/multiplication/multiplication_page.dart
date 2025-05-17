import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/bloc/multiplication_bloc.dart';
import 'package:imkon/features/utils/app_images.dart';

class MultiplicationPage extends StatefulWidget {
  const MultiplicationPage({super.key});

  @override
  State<MultiplicationPage> createState() => _MultiplicationPageState();
}

class _MultiplicationPageState extends State<MultiplicationPage> {
  @override
  void initState() {
    super.initState();
    context.read<MultiplicationBloc>().add(StartGameEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/math_fon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<MultiplicationBloc, MultiplicationState>(
          builder: (context, state) {
            if (state is StartGameState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'O\'yin boshlanishiga qoldi : ',
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  Text(
                    state.timer,
                    style: TextStyle(fontSize: 40, color: Colors.black),
                  ),
                ],
              );
            } else if (state is GameStarted) {
              return Center(
                child: Text(
                  'O\'yin boshlandi!',
                  style: TextStyle(fontSize: 32, color: Colors.green),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
