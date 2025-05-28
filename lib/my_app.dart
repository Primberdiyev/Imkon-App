import 'package:flutter/material.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/providers/multiplication_provider.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/services/audio_service.dart';
import 'package:imkon/features/splash/splash_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AudioService(),
        ),
        ChangeNotifierProvider(
          create: (_) => MultiplicationProvider(),
        ),
      ],
      child: MaterialApp(
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
