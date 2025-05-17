import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imkon/features/courses/math_course/pages/multiplication/bloc/multiplication_bloc.dart';
import 'package:imkon/features/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MultiplicationBloc())],
      child: MaterialApp(home: SplashPage(), debugShowCheckedModeBanner: false),
    );
  }
}
