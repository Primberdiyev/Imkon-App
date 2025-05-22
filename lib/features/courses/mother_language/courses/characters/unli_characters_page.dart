import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VowelCharactersPage extends StatefulWidget {
  const VowelCharactersPage({super.key});

  @override
  State<VowelCharactersPage> createState() => _VowelCharactersPageState();
}

class _VowelCharactersPageState extends State<VowelCharactersPage> {
  final List<String> vowels = ['A', 'E', 'I', 'O', 'U', "O'"];
  final Map<String, String> images = {
    'A': 'assets/images/unli/a.png',
    'E': 'assets/images/unli/e.jpg',
    'I': 'assets/images/unli/i.jpg',
    'O': 'assets/images/unli/o.jpg',
    'U': 'assets/images/unli/u.jpg',
    "O'": "assets/images/unli/o'.jpg",
  };

  final List<Color> bgColors = [
    Colors.red.shade100,
    Colors.yellow.shade100,
    Colors.cyan.shade100,
    Colors.deepPurple.shade100,
    Colors.lightGreen.shade100,
    Colors.amber.shade100,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final letter = vowels[currentIndex];
    final imagePath = images[letter] ?? '';
    final bgColor = bgColors[currentIndex % bgColors.length];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "Unli harfni o'rganing!",
          style: GoogleFonts.fredoka(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                      child: Text(
                        letter,
                        key: ValueKey(letter),
                        style: GoogleFonts.fredoka(
                          fontSize: 140,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      transitionBuilder:
                          (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                      child: ClipRRect(
                        key: ValueKey<String>(imagePath),
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imagePath,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: text-to-speech qo‘shiladi
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.volume_up),
                      label: const Text(
                        "Eshitish",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (currentIndex < vowels.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text("Tabriklaymiz! 🎉"),
                                  content: const Text(
                                    "Siz barcha unli harflarni muvaffaqiyatli ko‘rdingiz!",
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Bosh sahifa",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        currentIndex < vowels.length - 1
                            ? "Keyingi harf"
                            : "Yakunlash",
                        style: GoogleFonts.fredoka(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
