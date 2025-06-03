import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/features/introduction/pages/asking_where_page.dart';

class SayingBirdPage extends StatelessWidget {
  const SayingBirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Container(
            width: 230,
            height: 150,
            // margin: EdgeInsets.only(left: 160),
            margin: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width) / 2 - 50),
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFAAB0B7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Salom, Men sizning Yordamchingiz, Imkon ilova bo\'laman',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Image.asset(
              'assets/images/saying_bird.png',
              height: 150,
              width: 150,
            ),
          ),
          Spacer(),
          Center(
            child: CustomButton(
              function: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AskingWherePage()),
                );
              },
              text: 'Davom Ettirish',
              textSize: 24,
              buttonColor: Color(0xFFFFD700),
              textColor: Colors.white,
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
