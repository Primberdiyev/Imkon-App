import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DivisionGamePage extends StatefulWidget {
  const DivisionGamePage({super.key});

  @override
  State<DivisionGamePage> createState() => _DivisionGamePageState();
}

class _DivisionGamePageState extends State<DivisionGamePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<int> divisors = [2, 5, 1, 2];
  int startNumber = 0;
  int currentIndex = -1;
  bool showInput = false;
  int preCountdown = 5;
  int countdown = 10;
  Timer? timer;
  TextEditingController controller = TextEditingController();
  int count = 0;
  final List<int> possibleStartNumbers = [60, 80, 100, 120];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    generateStartNumber();
    startPreCountdown();
  }

  void generateStartNumber() {
    startNumber =
        possibleStartNumbers[random.nextInt(possibleStartNumbers.length)];
  }

  void startPreCountdown() {
    setState(() {
      currentIndex = -1;
      showInput = false;
      preCountdown = 5;
      countdown = 10;
      controller.clear();
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        preCountdown--;
        if (preCountdown == 0) {
          t.cancel();
          startDivisionProcess();
        }
      });
    });
  }

  void startDivisionProcess() {
    setState(() {
      currentIndex = 0;
    });
    startNextNumberTimer();
  }

  void startNextNumberTimer() {
    setState(() {
      countdown = 10;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          t.cancel();
          if (currentIndex < divisors.length) {
            currentIndex++;
            startNextNumberTimer();
          } else {
            showInput = true;
          }
        }
      });
    });
  }

  void checkAnswer() async {
    int userAnswer = int.tryParse(controller.text.trim()) ?? 0;
    int currentValue = startNumber;
    for (int i = 0; i < divisors.length; i++) {
      currentValue = currentValue ~/ divisors[i];
    }
    int correctAnswer = currentValue;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              userAnswer == correctAnswer ? "✅ Barakalla!" : "❌ Notog'ri",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Siz kiritdingiz: $userAnswer"),
                Text("To'g'ri javob: $correctAnswer"),
                const SizedBox(height: 10),
                Text("Boshlang'ich son: $startNumber"),
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
                  startNewGame();
                },
                child: const Text(
                  "Yana o'ynash",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
    if (userAnswer == correctAnswer) {
      if (userAnswer == correctAnswer) {
        await _audioPlayer.play(AssetSource('musics/success1.mp3'));
      }
    }
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
      displayText = "O'yin boshlanishiga qoldi:\n$preCountdown";
    } else if (!showInput &&
        currentIndex >= 0 &&
        currentIndex <= divisors.length) {
      if (currentIndex == 0) {
        displayText = "$startNumber";
      } else if (currentIndex < divisors.length) {
        displayText = "÷ ${divisors[currentIndex]}";
      } else if (currentIndex == divisors.length) {
        displayText = "÷ ${divisors.last}";
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Container(
        decoration: const BoxDecoration(
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
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: checkAnswer,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: const Size(200, 50),
                      backgroundColor: const Color(0xFF1E90FF),
                    ),
                    child: const Text(
                      "Tekshirish",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
