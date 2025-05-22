import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  final List<Map<String, String>> words = [
    {"word": "Ota", "image": "assets/images/family/ota.jpg"},
    {"word": "Ona", "image": "assets/images/family/ona.jpg"},
    {"word": "Bola", "image": "assets/images/family/bola.jpg"},
    {"word": "Qizi", "image": "assets/images/family/qizi.jpg"},
    {"word": "O‘g‘il", "image": "assets/images/family/ogil.jpg"},
    {"word": "Bobo", "image": "assets/images/family/bobo.jpg"},
    {"word": "Buvijon", "image": "assets/images/family/buvijon.jpg"},
    {"word": "Opa", "image": "assets/images/family/opa.jpg"},
    {"word": "Uka", "image": "assets/images/family/uka.jpg"},
    {"word": "Xola", "image": "assets/images/family/xola.jpg"},
  ];

  final List<Color> bgColors = [
    Colors.red.shade200,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.purple.shade300,
    Colors.pink.shade300,
    Colors.teal.shade300,
    Colors.cyan.shade300,
    Colors.lime.shade300,
  ];

  int currentIndex = 0;
  int countdown = 10;
  Timer? timer;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimers();
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
        }
      });
    });
  }

  void showDialogToUser() {
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
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 280,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      currentIndex == 4
                          ? "Namoyish etilgan so'zlarni ustozingizga ayting va ixtiyoriy 2 tasini tanlab gap tuzing."
                          : "Namoyish etilgan so'zlardan foydalanib Hikoya tuzing va uni ustozingizga aytib bering!",
                      style: GoogleFonts.poppins(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                                color: isSelected
                                    ? Colors.deepPurple
                                    : Colors.black,
                              ),
                            ),
                            value: isSelected,
                            activeColor: Colors.deepPurple,
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
                    ),
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
                    backgroundColor: Colors.deepPurple,
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
                      // Oxirgi dialogda faqat shu amal bajariladi
                      Navigator.pop(context); // Pop contextni ham yoping
                    } else if (currentIndex == 4) {
                      setState(() {
                        currentIndex = 5;
                        countdown = 10;
                      });
                      startTimers();
                    }
                  },
                  child: Text(
                    currentIndex == 9 ? "Bajarildi" : "Bajarildi",
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = bgColors[currentIndex % bgColors.length];
    final currentWord = words[currentIndex];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Oila So'zlari"),
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
                      color: Colors.deepPurple.withOpacity(0.3),
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
                    color: Colors.deepPurple.shade700,
                    shadows: [
                      Shadow(
                        color: Colors.deepPurple.shade200,
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
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
