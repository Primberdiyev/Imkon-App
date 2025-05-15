import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/cources/math_cource/dialogs/attention_dialog.dart';
import 'package:imkon/features/cources/math_cource/pages/math_game_beginner.dart';
import 'package:imkon/features/cources/math_cource/pages/multiplication_page.dart';

class MathCourcePage extends StatelessWidget {
  const MathCourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Kerakli bo'limlardan birini tanlash", maxLines: 2),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            CustomButton(
              function: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AttentionDialog(
                        function: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MathGameBeginner(),
                            ),
                          );
                        },
                        text:
                            'Sizga random sonlar beriladi va siz ularni tezkorlik bilan hisoblashingiz kerak.\n\nO‘yin boshlaymizmi?',
                      ),
                );
              },
              text: '(0...............99)±',
              textSize: 24,
              buttonColor: Color(0xFFFF9E9E),
              textColor: Color(0xFF000000),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomButton(
                function: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AttentionDialog(
                          function: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiplicationGamePage(),
                              ),
                            );
                          },
                          text:
                              'Sizga random sonlar beriladi va siz ularni tezkorlik bilan kopaytirishingiz kerak.\n\nO‘yin boshlaymizmi?',
                        ),
                  );
                },
                text: '(0...............9) x',
                textSize: 24,
                buttonColor: Color(0xFF91F48F),
                textColor: Color(0xFF000000),
              ),
            ),
            CustomButton(
              text: '(0...............50) %',
              textSize: 24,
              buttonColor: Color(0xFFFFF599),
              textColor: Color(0xFF000000).withValues(alpha: 0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomButton(
                text: '(0...............50) ± x  %',
                textSize: 24,
                buttonColor: Color(0xFFB69CFF),
                textColor: Color(0xFF000000).withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
