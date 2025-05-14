import 'package:flutter/material.dart';
import 'package:imkon/features/ask_question/ask_question.dart';
import 'package:imkon/features/fields/fields.dart';
import 'package:imkon/features/profile/profile.dart';
import 'package:imkon/features/statistics/statics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => _currentIndex.value = index,
        children: const [Fields(), AskQuestion(), Statics(), Profile()],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndex.value = index;
              _pageController.jumpToPage(index);
            },
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Kurslar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer),
                label: 'Savol So\'rash',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Statistika',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}
