import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/courses/math_course/dialogs/attention_dialog.dart';
import 'package:imkon/features/courses/mother_language/courses/words/family_page.dart';
import 'package:imkon/features/courses/mother_language/courses/words/school_page.dart';
import 'package:imkon/features/courses/mother_language/courses/words/social_life.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({super.key});

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
                            MaterialPageRoute(builder: (_) => FamilyPage()),
                          );
                        },
                        text:
                            'Sizga Oila mavzusida so\'zlar beriladi va siz ulardan ketma ketligini aytishingingiz, gap tuzishingiz va Hikoya yaratishingiz kerak.\n\n boshlaymizmi?',
                      ),
                );
              },
              text: 'Oila',
              textSize: 20,
              buttonColor: Colors.orange,
              textColor: Colors.black,
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
                            MaterialPageRoute(builder: (_) => SchoolPage()),
                          );
                        },
                        text:
                            'Sizga Maktab mavzusida so\'zlar beriladi va siz ulardan ketma ketligini aytishingingiz, gap tuzishingiz va Hikoya yaratishingiz kerak.   \n\n boshlaymizmi?',
                      ),
                );
              },
              text: "Maktab",
              textSize: 20,
              buttonColor: Colors.green,
              textColor: Colors.black,
            ),
            SizedBox(height: 30),

            CustomButton(
              text: "Ijtimoiy Hayot",
              textSize: 20,
              buttonColor: Colors.yellow,
              textColor: Colors.black,
              function: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AttentionDialog(
                        function: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SocialLifePage()),
                          );
                        },
                        text:
                            'Sizga Ijtimoiy hayot mavzusida so\'zlar beriladi va siz ulardan ketma ketligini aytishingingiz, gap tuzishingiz va Hikoya yaratishingiz kerak.   \n\n boshlaymizmi?',
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
