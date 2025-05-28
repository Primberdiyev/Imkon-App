import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/courses/math_course/dialogs/attention_dialog.dart';
import 'package:imkon/features/courses/mother_language/courses/characters/all_characters_page.dart';
import 'package:imkon/features/courses/mother_language/courses/characters/undosh_characters_page.dart';
import 'package:imkon/features/courses/mother_language/courses/characters/unli_characters_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kerakli bo'limni tanlang")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                              builder: (_) => AllCharactersPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga barcha harflar namoyish etiladi va siz ularni talaffuz qilishing kerak.\n\ boshlaymizmi?',
                      ),
                );
              },
              text: 'Barcha harflar',
              textSize: 20,
              buttonColor: Colors.green,
              textColor: Colors.white,
            ),

            SizedBox(height: 30),
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
                              builder: (_) => VowelCharactersPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga unli harflar namoyish etilari va siz ularni talaffuz qilishing kerak.\n\n boshlaymizmi?',
                      ),
                );
              },
              text: 'Unli harflar',
              textSize: 20,
              buttonColor: Colors.indigoAccent,
              textColor: Colors.white,
            ),
            SizedBox(height: 30),
            CustomButton(
              text: 'Undosh harflar',
              textSize: 20,
              buttonColor: Colors.red,
              textColor: Colors.white,
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
                              builder: (_) => ConsonantCharactersPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga undosh harflar namoyish etilari va siz ularni talaffuz qilishing kerak.\n\n boshlaymizmi?',
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
