import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCharactersPage extends StatefulWidget {
  const AllCharactersPage({super.key});

  @override
  State<AllCharactersPage> createState() => _AllCharactersPageState();
}

class _AllCharactersPageState extends State<AllCharactersPage>
    with SingleTickerProviderStateMixin {
  final List<String> letters = ['A', 'B', 'D', 'E'];
  final Map<String, String> images = {
    'A': 'assets/images/characters/a.jpg',
    'B': 'assets/images/characters/b.jpg',
    'D': 'assets/images/characters/d.jpg',
    'E': 'assets/images/characters/e.jpg',
  };

  final List<Color> bgColors = [
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final letter = letters[currentIndex];
    final imagePath = images[letter] ?? '';
    final bgColor = bgColors[currentIndex % bgColors.length];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Text(
                "Harf bilan tanishing!",
                style: GoogleFonts.fredoka(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Column(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: text-to-speech qo'shiladi
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
                      if (currentIndex < letters.length - 1) {
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
                                  "Siz barcha harflarni muvaffaqiyatli ko‘rdingiz!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context); // or go home
                                    },
                                    child: const Text("Bosh sahifa"),
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      currentIndex < letters.length - 1
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
    );
  }
}
