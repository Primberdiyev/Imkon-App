import 'package:flutter/material.dart';
import 'package:imkon/features/home/pages/home_page.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.whiteFone),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(AppImages.bigBird, height: 200, width: 200),
        ),
      ),
    );
  }
}
