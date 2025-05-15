import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MultiplicationGamePage extends StatefulWidget {
  const MultiplicationGamePage({super.key});

  @override
  State<MultiplicationGamePage> createState() => _MultiplicationGamePageState();
}

class _MultiplicationGamePageState extends State<MultiplicationGamePage> {
  List<int> numbers = [];
  int currentIndex = -1;
  bool showInput = false;
  int preCountdown = 5;
  int countdown = 5;
  Timer? timer;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateNumbers();
    startPreCountdown();
  }

  void generateNumbers() {
    numbers.clear();
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      numbers.add(random.nextInt(4) + 1);
    }
  }

  void startPreCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        preCountdown--;
        if (preCountdown == 0) {
          t.cancel();
          startNextNumberTimer();
          currentIndex = 0;
        }
      });
    });
  }

  void startNextNumberTimer() {
    countdown = 10;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          t.cancel();
          if (currentIndex < numbers.length - 1) {
            currentIndex++;
            startNextNumberTimer();
          } else {
            showInput = true;
          }
        }
      });
    });
  }

  void checkAnswer() {
    int userAnswer = int.tryParse(controller.text.trim()) ?? 0;
    int correctAnswer = numbers.fold(1, (prev, element) => prev * element);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              userAnswer == correctAnswer ? "✅ Barakalla!" : "❌ Notog‘ri",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Siz kiritdingiz: $userAnswer"),
                Text("To‘g‘ri javob: $correctAnswer"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Bosh Sahifa"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  restartGame();
                },
                child: const Text(
                  "Yana o‘ynash",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void restartGame() {
    setState(() {
      controller.clear();
      currentIndex = -1;
      showInput = false;
      preCountdown = 5;
    });
    generateNumbers();
    startPreCountdown();
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? displayText;

    if (preCountdown > 0) {
      displayText = "O‘yin boshlanishiga qoldi:\n$preCountdown";
    } else if (!showInput &&
        currentIndex >= 0 &&
        currentIndex < numbers.length) {
      displayText =
          currentIndex == 0
              ? "${numbers[currentIndex]}"
              : "x ${numbers[currentIndex]}";
    }

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/math_fon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (displayText != null)
                  Text(
                    displayText,
                    style: const TextStyle(fontSize: 48),
                    textAlign: TextAlign.center,
                  ),
                if (!showInput && preCountdown == 0)
                  Text(
                    "⏱ $countdown",
                    style: const TextStyle(fontSize: 24, color: Colors.red),
                  ),
                if (showInput) ...[
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Javobingizni kiriting",
                    ),
                  ),
                  const SizedBox(height: 100),
                  TextButton(
                    onPressed: checkAnswer,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: Size(200, 50),
                      backgroundColor: Color(0xFFFFD700),
                    ),
                    child: const Text(
                      "Tekshirish",
                      style: TextStyle(
                        fontFamily: 'myFirstFont',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
