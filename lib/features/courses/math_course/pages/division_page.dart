import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class DivisionGamePage extends StatefulWidget {
  const DivisionGamePage({super.key});

  @override
  State<DivisionGamePage> createState() => _DivisionGamePageState();
}

class _DivisionGamePageState extends State<DivisionGamePage> {
  int preCountdown = 5;
  int questionCountdown = 10;
  Timer? timer;
  Timer? questionTimer;
  final TextEditingController controller = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentLevel = 1;
  int currentQuestion = 0;
  bool showInput = false;
  bool showResult = false;
  bool isCorrect = false;
  int score = 0;
  bool buttonPressed = false;

  final List<Map<String, dynamic>> level1Questions = [
    {'a': 60, 'b': 2, 'answer': 30, 'music': 'musics/div0.mp3'},
    {'a': 80, 'b': 4, 'answer': 20, 'music': 'musics/div1.mp3'},
    {'a': 100, 'b': 5, 'answer': 20, 'music': 'musics/div2.mp3'},
    {'a': 30, 'b': 1, 'answer': 30, 'music': 'musics/div3.mp3'},
    {'a': 80, 'b': 5, 'answer': 16, 'music': 'musics/div4.mp3'},
  ];

  final List<Map<String, dynamic>> level2Questions = [
    {'a': 36, 'b': 3, 'answer': 12, 'music': 'musics/div5.mp3'},
    {'a': 28, 'b': 14, 'answer': 2, 'music': 'musics/div6.mp3'},
    {'a': 45, 'b': 5, 'answer': 9, 'music': 'musics/div7.mp3'},
    {'a': 40, 'b': 8, 'answer': 5, 'music': 'musics/div8.mp3'},
    {'a': 15, 'b': 15, 'answer': 1, 'music': 'musics/div9.mp3'},
  ];

  List<Map<String, dynamic>> get questions =>
      currentLevel == 1 ? level1Questions : level2Questions;

  @override
  void initState() {
    super.initState();
    startPreCountdown(false);
  }

  Future<void> playQuestionAudio() async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(questions[currentQuestion]['music']));
    } catch (e) {
      print("Audio o'ynatishda xato: $e");
    }
  }

  Future<void> playCorrectSound() async {
    await audioPlayer.play(AssetSource('musics/togri.mp3'));
  }

  Future<void> playWrongSound() async {
    await audioPlayer.play(AssetSource('musics/notogri.mp3'));
  }

  void startPreCountdown(bool condition) {
    setState(() {
      preCountdown = 5;
      showInput = false;
      controller.clear();
      currentQuestion = 0;
      score = 0;
      buttonPressed = false;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        preCountdown--;
        if (preCountdown == 0) {
          t.cancel();
          setState(() {
            showInput = true;
          });
          playQuestionAudio();

          if (currentLevel == 2) {
            startQuestionTimer();
          }
        }
      });
    });
    if (condition) {
      audioPlayer.play(AssetSource('musics/diqqat_boshlanmoqda.mp3'));
    }
  }

  void startQuestionTimer() {
    questionTimer?.cancel();
    questionCountdown = 10;

    questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        questionCountdown--;
        if (questionCountdown == 0) {
          timer.cancel();
          checkAnswer(skip: true);
        }
      });
    });
  }

  Future<void> checkAnswer({bool skip = false}) async {
    questionTimer?.cancel();

    setState(() {
      buttonPressed = true;

      int userAnswer = skip ? -1 : int.tryParse(controller.text.trim()) ?? -1;
      int correctAnswer = questions[currentQuestion]['answer'];

      isCorrect = userAnswer == correctAnswer;
      if (isCorrect) {
        score++;
        playCorrectSound();
      } else {
        playWrongSound();
      }

      showResult = true;
    });
    controller.clear();
  }

  void nextQuestion() {
    setState(() {
      currentQuestion++;
      controller.clear();
      showResult = false;
      buttonPressed = false;

      if (currentQuestion >= questions.length) {
        showFinalDialog();
      } else if (currentLevel == 2) {
        startQuestionTimer();
      }

      // Yangi savol audio faylini ijro etish
      if (currentQuestion < questions.length) {
        playQuestionAudio();
      }
    });
  }

  void showFinalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: const Center(child: Text("O'yin tugadi!")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Siz ${questions.length} ta savoldan $score tasini topdingiz.",
                ),
                const Text("O'z ustingizda ishlashdan also to'xtamang"),
              ],
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Bosh sahifa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      if (currentLevel == 1) {
                        currentLevel = 2;
                      }
                      startPreCountdown(true);
                    },
                    child: Text(
                      currentLevel == 1 ? "Keyingi bosqich" : "Yana o'ynash",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
    AudioPlayer().play(AssetSource('musics/multip_finish.mp3'));
  }

  @override
  void dispose() {
    timer?.cancel();
    questionTimer?.cancel();
    controller.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (preCountdown > 0) {
      content = Text(
        "O'yin boshlanishiga qoldi:\n$preCountdown",
        style: const TextStyle(fontSize: 36),
        textAlign: TextAlign.center,
      );
    } else if (currentQuestion < questions.length) {
      final q = questions[currentQuestion];
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${q['a']} ÷ ${q['b']} = ?",
            style: const TextStyle(fontSize: 36),
          ),
          if (currentLevel == 2)
            Text(
              "Vaqt: $questionCountdown",
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          const SizedBox(height: 20),
          if (showInput)
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Javobingizni kiriting",
              ),
            ),
          const SizedBox(height: 20),
          if (showInput && !showResult)
            TextButton(
              onPressed: () => checkAnswer(),
              style: TextButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor:
                    buttonPressed ? Colors.green : const Color(0xFF1E90FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Tekshirish",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          if (showResult) ...[
            const SizedBox(height: 20),
            Text(
              isCorrect
                  ? "✅ Tabriklaymiz, Siz to'g'ri bajardingiz!"
                  : "❌ Misolning to'g'ri javobi ${q['answer']} edi.",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: nextQuestion,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Keyingi",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ],
      );
    } else {
      content = const SizedBox();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/math_fon.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(padding: const EdgeInsets.all(20), child: content),
            ),
          ),
          const Positioned(
            top: 60,
            left: 10,
            child: BackButton(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
