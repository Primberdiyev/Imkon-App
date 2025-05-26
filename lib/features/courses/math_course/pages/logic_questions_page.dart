import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LogicQuestionsPage extends StatefulWidget {
  const LogicQuestionsPage({super.key});

  @override
  State<LogicQuestionsPage> createState() => _LogicQuestionsPageState();
}

class _LogicQuestionsPageState extends State<LogicQuestionsPage> {
  int preCountdown = 5;
  int currentQuestion = 0;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Timer? countdownTimer; // <-- Timer uchun

  final List<Map<String, String>> questions = [
    {
      'question':
          'Bir kishi har kuni soat 7:00 da ishga boradi va 8 soat ishlaydi. Agar ish vaqti 2 soatga ko‘paytirilsa, u necha soat ishlaydi?',
      'answer': '10 soat',
      'music': 'musics/logic0.mp3',
      'answer_music': 'musics/logic_ans0.mp3',
    },
    {
      'question':
          'Qaysi raqam ketma-ketligida teskari tartibda bo‘lsa ham, bir xil qoladi: 121, 343, 45654, yoki 78987?',
      'answer': 'Keltirilgan sonlarning barchasi',
      'music': 'musics/logic1.mp3',
      'answer_music': 'musics/logic_ans1.mp3',
    },
    {
      'question':
          'Agar sizda 8 ta olma bo‘lsa, ularni 4 kishiga teng taqsimlash uchun necha olma berasiz?',
      'answer': 'Har bir kishiga 2 tadan olma',
      'music': 'musics/logic2.mp3',
      'answer_music': 'musics/logic_ans2.mp3',
    },
    {
      'question':
          'Bir qutida 10 ta shokolad bor, har kuni 2 tasi yeyiladi. Necha kunda shokoladlar tugaydi?',
      'answer': '5 kun',
      'music': 'musics/logic3.mp3',
      'answer_music': 'musics/logic_ans3.mp3',
    },
    {
      'question':
          '7 ta kitob bor, har birida 10 tadan sahifa  bor. Umumiy nechta sahifa bor?',
      'answer': '70 sahifa',
      'music': 'musics/logic4.mp3',
      'answer_music': 'musics/logic_ans4.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    startPreCountdown();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel(); // <-- Timer to‘xtatiladi
    audioPlayer.dispose();
    super.dispose();
  }

  void startPreCountdown() {
    setState(() {
      preCountdown = 5;
      currentQuestion = 0;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        preCountdown--;
        if (preCountdown == 0) {
          timer.cancel();
          playQuestionAudio();
        }
      });
    });
  }

  Future<void> playQuestionAudio() async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(questions[currentQuestion]['music']!));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> playAnswerAudio() async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(
        AssetSource(questions[currentQuestion]['answer_music']!),
      );
    } catch (e) {
      debugPrint('Error playing answer audio: $e');
    }
  }

  void showAnswer() {
    playAnswerAudio();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            alignment: Alignment.center,
            title: const Text("Javob"),
            content: Text(questions[currentQuestion]['answer']!),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.stop();
                  }
                  Navigator.pop(context); // AlertDialog yopiladi
                  Navigator.pop(context); // Bosh sahifaga qaytadi
                },
                child: const Text(
                  "Bosh sahifa",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              if (currentQuestion < questions.length - 1)
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    audioPlayer.stop();
                    Navigator.pop(context);
                    setState(() {
                      currentQuestion++;
                    });
                    playQuestionAudio();
                  },
                  child: const Text(
                    "Keyingi savol",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child:
                    preCountdown > 0
                        ? Text(
                          "O'yin boshlanishiga qoldi:\n$preCountdown",
                          style: const TextStyle(fontSize: 36),
                          textAlign: TextAlign.center,
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              questions[currentQuestion]['question']!,
                              style: const TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 36,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await audioPlayer.pause();
                                    } else {
                                      await playQuestionAudio();
                                    }
                                  },
                                ),
                                const SizedBox(width: 20),
                                TextButton(
                                  onPressed: showAnswer,
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF1E90FF),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "Javobni bilish",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
              ),
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
