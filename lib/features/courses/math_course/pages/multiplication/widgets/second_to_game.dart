import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/providers/multiplication_provider.dart';

class SecondToGame extends StatelessWidget {
  const SecondToGame({super.key});

  @override
  Widget build(BuildContext context) {
    final countdown = context.watch<MultiplicationProvider>().countdown;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'O\'yin boshlanmoqda...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            countdown.toString(),
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset(3, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
