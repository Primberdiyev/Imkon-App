import 'package:flutter/material.dart';
import 'package:imkon/features/home/pages/home_page.dart';
import 'package:imkon/features/introduction/pages/begin_page.dart';
import 'package:imkon/features/splash/providers/auth_provider.dart';
import 'package:imkon/features/utils/app_images.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthStatus();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => authProvider.currentUser != null
            ? const HomePage()
            : const BeginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700),
      body: Center(
        child: Image.asset(AppImages.bigBird, height: 200, width: 200),
      ),
    );
  }
}
