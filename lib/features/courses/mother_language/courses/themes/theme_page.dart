import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/courses/math_course/dialogs/attention_dialog.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/animals_match.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/nature_phenomena_page.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/seasons_page.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/sport_match_page.dart';


class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kerakli bo'limni tanlang",)),
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
                            MaterialPageRoute(builder: (_) => SeasonsPage()),
                          );
                        },
                        text:
                            'Sizga Fasillar mavzusida so\'zlar beriladi.   \n\n boshlaymizmi?',
                      ),
                );
              },
              text: 'Fasillar',
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
                            MaterialPageRoute(
                              builder: (_) => AnimalsMatchPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga Hayvonlar mavzusida so\'zlar beriladi.   \n\n boshlaymizmi?',
                      ),
                );
              },
              text: "Hayvonlar",
              textSize: 20,
              buttonColor: Colors.green,
              textColor: Colors.black,
            ),
            SizedBox(height: 30),

            CustomButton(
              text: "Tabiat Hodisalari",
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
                            MaterialPageRoute(
                              builder: (_) => NaturePhenomenaMatchPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga Tabiat Hodisalari mavzusida so\'zlar beriladi.   \n\n boshlaymizmi?',
                      ),
                );
              },
            ),
            SizedBox(height: 30),
            CustomButton(
              text: "Sport turlari",
              textSize: 20,
              buttonColor: Colors.blue,
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
                            MaterialPageRoute(
                              builder: (_) => SportsMatchPage(),
                            ),
                          );
                        },
                        text:
                            'Sizga Sport turlari  mavzusida so\'zlar beriladi.   \n\n boshlaymizmi?',
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
