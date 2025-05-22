import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/courses/math_course/dialogs/attention_dialog.dart';
import 'package:imkon/features/courses/math_course/pages/math_game_beginner.dart';
import 'package:imkon/features/courses/mother_language/courses/characters/characters_page.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/theme_page.dart';
import 'package:imkon/features/courses/mother_language/courses/words/words_page.dart';

class MotherLanguagePage extends StatelessWidget {
  const MotherLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Kerakli bo'limlardan birini tanlang", maxLines: 2),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            CustomButton(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CharactersPage()),
                );
              },
              text: 'Harflar',
              textSize: 24,
              buttonColor: Color(0xFFFF9E9E),
              textColor: Color(0xFF000000),
            ),
            SizedBox(height: 30),
            CustomButton(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordsPage()),
                );
              },
              text: "So'zlar",
              textSize: 24,
              buttonColor: Color(0xFF91F48F),
              textColor: Color(0xFF000000),
            ),
            SizedBox(height: 30),
            CustomButton(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemePage()),
                );
              },
              text: 'Mavzular',
              textSize: 24,
              buttonColor: Color(0xFFFFF599),
              textColor: Color(0xFF000000),
            ),
          ],
        ),
      ),
    );
  }
}
