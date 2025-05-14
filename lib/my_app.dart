import 'package:flutter/material.dart';
import 'package:imkon/features/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage(), debugShowCheckedModeBanner: false);
  }
}
