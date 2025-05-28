import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class VowelCharactersPage extends StatefulWidget {
  const VowelCharactersPage({super.key});

  @override
  State<VowelCharactersPage> createState() => _VowelCharactersPageState();
}

class _VowelCharactersPageState extends State<VowelCharactersPage> {
  final List<String> vowels = ['A', 'E', 'I', 'O', 'U', "O'"];
  final Map<String, String> images = {
    'A': 'assets/images/unli/archa.png',
    'E': 'assets/images/unli/eshik.jpg',
    'I': 'assets/images/unli/iz.jpg',
    'O': 'assets/images/unli/olma.jpg',
    'U': 'assets/images/unli/uzum.jpg',
    "O'": "assets/images/unli/o'rmon.jpg",
  };

  // Letter sounds mapping
  final Map<String, String> letterSounds = {
    'A': 'musics/a.mp3',
    'E': 'musics/e.mp3',
    'I': 'musics/i.mp3',
    'O': 'musics/o.mp3',
    'U': 'musics/u.mp3',
    "O'": "musics/o'.mp3",
  };

  // Image sounds mapping (words)
  final Map<String, String> imageSounds = {
    'A': 'musics/archa.mp3',
    'E': 'musics/eshik.mp3',
    'I': 'musics/iz.mp3',
    'O': 'musics/olma.mp3',
    'U': 'musics/uzum.mp3',
    "O'": "musics/o'rmon.mp3",
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
    final letter = vowels[currentIndex];
    final imagePath = images[letter] ?? '';
    final bgColor = bgColors[currentIndex % bgColors.length];
    final letterSound = letterSounds[letter] ?? '';
    final imageSound = imageSounds[letter] ?? '';

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
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 700),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: ClipRRect(
                            key: ValueKey<String>(imagePath),
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              imagePath,
                              height: 250,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
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
                        if (currentIndex < vowels.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Tabriklaymiz! 🎉"),
                              content: const Text(
                                "Siz barcha unli harflarni muvaffaqiyatli ko'rdigiz!",
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
