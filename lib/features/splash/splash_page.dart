import 'package:flutter/material.dart';
import 'package:imkon/features/home/pages/home_page.dart';
import 'package:imkon/features/introduction/pages/begin_page.dart';
import 'package:imkon/features/utils/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(AppImages.bigBird, height: 200, width: 200),
      ),
    );
  }
}
