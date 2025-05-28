import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class AllCharactersPage extends StatefulWidget {
  const AllCharactersPage({super.key});

  @override
  State<AllCharactersPage> createState() => _AllCharactersPageState();
}

class _AllCharactersPageState extends State<AllCharactersPage>
    with SingleTickerProviderStateMixin {
  final List<String> letters = ['A', 'B', 'D', 'E'];
  final Map<String, String> images = {
    'A': 'assets/images/characters/anor.jpg',
    'B': 'assets/images/characters/bahor.jpg',
    'D': 'assets/images/characters/daraxt.jpg',
    'E': 'assets/images/characters/echki.jpg',
  };

  final Map<String, String> letterSounds = {
    'A': 'musics/a.mp3',
    'B': 'musics/b.mp3',
    'D': 'musics/d.mp3',
    'E': 'musics/e.mp3',
  };

  final Map<String, String> imageSounds = {
    'A': 'musics/anor.mp3',
    'B': 'musics/bahor.mp3',
    'D': 'musics/daraxt.mp3',
    'E': 'musics/echki.mp3',
  };

  final List<Color> bgColors = [
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
  ];

  int currentIndex = 0;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound(String path) async {
    try {
      await audioPlayer.stop(); // Stop any currently playing sound
      await audioPlayer.play(AssetSource(path));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final letter = letters[currentIndex];
    final imagePath = images[letter] ?? '';
    final bgColor = bgColors[currentIndex % bgColors.length];
    final letterSound = letterSounds[letter] ?? '';
    final imageSound = imageSounds[letter] ?? '';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(backgroundColor: bgColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) =>
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
                        IconButton(
                          icon: const Icon(Icons.volume_up, size: 30),
                          onPressed: () => playSound(letterSound),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            imagePath,
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up, size: 30),
                          onPressed: () => playSound(imageSound),
                        ),
                      ],
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
                            builder: (_) => AlertDialog(
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
      ),
    );
  }
}
