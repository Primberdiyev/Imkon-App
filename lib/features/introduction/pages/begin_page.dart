import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/introduction/pages/saying_bird_page.dart';
import 'package:imkon/features/utils/app_images.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(AppImages.bird, height: 120, width: 120),
            Text(
              'Imkon',
              style: TextStyle(
                fontSize: 40,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Xalqaro darajadagi ta\'lim interaktiv usulda!',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              function: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SayingBirdPage()),
                );
              },
              text: 'Boshlash',
              textSize: 28,
              buttonColor: Color(0xFFFFD700),
              textColor: Colors.white,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
