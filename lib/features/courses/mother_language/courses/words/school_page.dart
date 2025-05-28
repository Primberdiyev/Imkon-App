import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imkon/features/utils/app_images.dart';
import 'package:audioplayers/audioplayers.dart'; // Add this import

class SchoolPage extends StatefulWidget {
  const SchoolPage({Key? key}) : super(key: key);

  @override
  State<SchoolPage> createState() => _MaktabPageState();
}

class _MaktabPageState extends State<SchoolPage> {
  final List<Map<String, String>> words = [
    {
      "word": "O'quvchi",
      "image": "assets/images/school/oquvchi.jpg",
      'music': 'musics/oquvchi.mp3'
    },
    {
      "word": "O'qituvchi",
      "image": "assets/images/school/oqituvchi.jpg",
      'music': 'musics/oqituvchi.mp3'
    },
    {
      "word": "Sinfxona",
      "image": "assets/images/school/sinfxona.jpg",
      'music': 'musics/sinfxona.mp3'
    },
    {
      "word": "Darslik",
      "image": "assets/images/school/darslik.jpg",
      'music': 'musics/darslik.mp3'
    },
    {
      "word": "Sport Zal",
      "image": "assets/images/school/sport.jpg",
      'music': 'musics/sport_zal.mp3'
    },
    {
      "word": "Reja",
      "image": "assets/images/school/reja.jpg",
      'music': 'musics/reja.mp3'
    },
    {
      "word": "Tadbir",
      "image": "assets/images/school/tadbir.jpg",
      'music': 'musics/tadbir.mp3'
    },
    {
      "word": "Qo'ng'iroq",
      "image": "assets/images/school/qongiroq.jpg",
      'music': 'musics/qongiroq.mp3'
    },
    {
      "word": "Imtihon",
      "image": "assets/images/school/imtihon.jpg",
      'music': 'musics/imtihon.mp3'
    },
    {
      "word": "Diplom",
      "image": "assets/images/school/diplom.jpg",
      'music': 'musics/diplom.mp3'
    },
  ];

  final List<Color> bgColors = [
    Colors.blue.shade200,
    Colors.indigo.shade300,
    Colors.cyan.shade300,
    Colors.lightBlue.shade300,
    Colors.teal.shade300,
    Colors.green.shade300,
    Colors.lime.shade300,
    Colors.amber.shade300,
    Colors.orange.shade300,
    Colors.deepOrange.shade300,
  ];

  int currentIndex = 0;
  int countdown = 10;
  Timer? timer;
  Timer? countdownTimer;
  final AudioPlayer audioPlayer = AudioPlayer(); // Add audio player instance

  @override
  void initState() {
    super.initState();
    startTimers();
    _playCurrentWordAudio(); // Play audio for the first word
  }

  void _playCurrentWordAudio() async {
    try {
      await audioPlayer.play(AssetSource(words[currentIndex]['music']!));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void startTimers() {
    countdown = 10;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
      } else {
        setState(() {
          countdown--;
        });
      }
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        if (currentIndex == 4 || currentIndex == 9) {
          timer.cancel();
          countdownTimer?.cancel();
          showDialogToUser();
        } else {
          currentIndex++;
          countdown = 10;
          _playCurrentWordAudio(); // Play audio for the new word
        }
      });
    });
  }

  void showDialogToUser() async {
    // Play appropriate audio based on current index
    try {
      if (currentIndex == 4) {
        await audioPlayer.play(AssetSource('musics/select_and_create.mp3'));
      } else if (currentIndex == 9) {
        await audioPlayer.play(AssetSource('musics/hikoya_tuzing.mp3'));
      }
    } catch (e) {
      print('Error playing dialog audio: $e');
    }

    int startIndex = currentIndex == 4 ? 0 : 5;
    int endIndex = currentIndex == 4 ? 5 : 10;

    List<Map<String, String>> currentWords = words.sublist(
      startIndex,
      endIndex,
    );

    List<int> selectedIndexes = [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                "Tayyor! 🔥",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 280,
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentIndex == 4
                          ? "Namoyish etilgan so'zlarni ustozingizga ayting va ixtiyoriy 2 tasini tanlab gap tuzing."
                          : currentIndex == 9
                              ? "Endi ushbu so'zlardan foydalanib hikoya tuzing va ustozingizga ayting."
                              : "Namoyish etilgan so'zlardan foydalanib Hikoya tuzing va uni ustozingizga aytib bering!",
                      style: GoogleFonts.poppins(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (currentIndex != 9)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentWords.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndexes.contains(index);
                            return CheckboxListTile(
                              title: Text(
                                currentWords[index]["word"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color:
                                      isSelected ? Colors.indigo : Colors.black,
                                ),
                              ),
                              value: isSelected,
                              activeColor: Colors.indigo,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true &&
                                      selectedIndexes.length < 2) {
                                    selectedIndexes.add(index);
                                  } else if (value == false) {
                                    selectedIndexes.remove(index);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      )
                    else
                      Image.asset(AppImages.verify, width: 150, height: 150),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (currentIndex == 9) {
                      Navigator.pop(context);
                    } else if (currentIndex == 4) {
                      setState(() {
                        currentIndex = 5;
                        countdown = 10;
                      });
                      startTimers();
                      _playCurrentWordAudio(); // Play audio for the new word
                    }
                  },
                  child: Text(
                    currentIndex == 9 ? "Bosh sahifa" : "Bajarildi",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    countdownTimer?.cancel();
    audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = bgColors[currentIndex % bgColors.length];
    final currentWord = words[currentIndex];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Maktab So'zlari"),
        backgroundColor: bgColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        color: bgColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Container(
                  key: ValueKey<String>(currentWord["image"]!),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      currentWord["image"]!,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.45,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  currentWord["word"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                    shadows: [
                      Shadow(
                        color: Colors.indigo.shade200,
                        blurRadius: 10,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "$countdown soniya qoldi",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.volume_up, size: 40),
                color: Colors.indigo,
                onPressed: _playCurrentWordAudio,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
