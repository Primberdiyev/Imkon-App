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
  Timer? countdownTimer;
  final TextEditingController _answerController = TextEditingController();
  String? feedbackMessage;
  Color feedbackColor = Colors.transparent;
  bool isCheckingAnswer = false;

  final List<Map<String, String>> questions = [
    {
      'question':
          'Bir kishi har kuni soat 7:00 da ishga boradi va 8 soat ishlaydi. Agar ish vaqti 2 soatga ko‘paytirilsa, u necha soat ishlaydi?',
      'answer': '10',
      'music': 'musics/logic0.mp3',
      'answer_music': 'musics/logic_ans0.mp3',
    },
    {
      'question':
          'Qaysi raqam ketma-ketligida teskari tartibda bo‘lsa ham, bir xil qoladi: 121, 343, 45654, yoki 78987?',
      'answer': 'hammasi',
      'music': 'musics/logic1.mp3',
      'answer_music': 'musics/logic_ans1.mp3',
    },
    {
      'question':
          'Agar sizda 8 ta olma bo‘lsa, ularni 4 kishiga teng taqsimlash uchun necha olma berasiz?',
      'answer': '2',
      'music': 'musics/logic2.mp3',
      'answer_music': 'musics/logic_ans2.mp3',
    },
    {
      'question':
          'Bir qutida 10 ta shokolad bor, har kuni 2 tasi yeyiladi. Necha kunda shokoladlar tugaydi?',
      'answer': '5',
      'music': 'musics/logic3.mp3',
      'answer_music': 'musics/logic_ans3.mp3',
    },
    {
      'question':
          '7 ta kitob bor, har birida 10 tadan sahifa bor. Umumiy nechta sahifa bor?',
      'answer': '70',
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
    countdownTimer?.cancel();
    audioPlayer.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void startPreCountdown() {
    setState(() {
      preCountdown = 5;
      currentQuestion = 0;
      feedbackMessage = null;
      feedbackColor = Colors.transparent;
      _answerController.clear();
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

  Future<void> playFeedbackAudio(bool isCorrect) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(
        AssetSource(isCorrect ? 'musics/togri.mp3' : 'musics/notogri.mp3'),
      );

      // Wait for the audio to complete before proceeding
      await audioPlayer.onPlayerComplete.first;
    } catch (e) {
      debugPrint('Error playing feedback audio: $e');
    }
  }

  Future<void> checkAnswer() async {
    if (isCheckingAnswer) return;

    final userAnswer = _answerController.text.trim();
    final correctAnswer = questions[currentQuestion]['answer']!;

    if (userAnswer.isEmpty) return;

    setState(() {
      isCheckingAnswer = true;
    });

    final isCorrect =
        userAnswer.toLowerCase().contains(correctAnswer.toLowerCase());

    await playFeedbackAudio(isCorrect);

    setState(() {
      feedbackMessage = isCorrect ? "To'g'ri javob!" : "Noto'g'ri javob!";
      feedbackColor = isCorrect ? Colors.green : Colors.red;
    });

    if (isCorrect) {
      _answerController.clear();

      // Wait a moment before moving to next question
      await Future.delayed(const Duration(milliseconds: 500));

      // Clear feedback before moving to next question
      setState(() {
        feedbackMessage = null;
        feedbackColor = Colors.transparent;
      });

      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
        });
        await playQuestionAudio();
      } else {
        // All questions completed
        showCompletionDialog();
      }
    }

    setState(() {
      isCheckingAnswer = false;
    });

    // Clear feedback after 3 seconds only if it's a wrong answer
    if (!isCorrect) {
      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          feedbackMessage = null;
          feedbackColor = Colors.transparent;
        });
      });
    }
  }

  void showAnswer() {
    setState(() {
      feedbackMessage = null;
      feedbackColor = Colors.transparent;
    });

    playAnswerAudio();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
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
              Navigator.pop(context);
              Navigator.pop(context);
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
                  _answerController.clear();
                  feedbackMessage =
                      null; // Clear feedback when moving to next question
                  feedbackColor = Colors.transparent;
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

  void showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Tabriklaymiz!"),
        content: const Text("Barcha savollarga javob berdingiz!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Bosh sahifa"),
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
                child: preCountdown > 0
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
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _answerController,
                              decoration: const InputDecoration(
                                hintText: "Javobingizni kiriting...",
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                              onSubmitted: (_) => checkAnswer(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: feedbackColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: feedbackMessage != null
                                ? Text(
                                    feedbackMessage!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
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
                              ElevatedButton(
                                onPressed:
                                    isCheckingAnswer ? null : checkAnswer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E90FF),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: isCheckingAnswer
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        "Javobni tekshirish",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.lightbulb_outline,
                                    size: 36, color: Colors.amber),
                                onPressed: showAnswer,
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
