import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class ConsonantCharactersPage extends StatefulWidget {
  const ConsonantCharactersPage({super.key});

  @override
  State<ConsonantCharactersPage> createState() =>
      _ConsonantCharactersPageState();
}

class _ConsonantCharactersPageState extends State<ConsonantCharactersPage> {
  final List<String> consonants = ['B', 'D', 'F', 'G', 'H'];
  final Map<String, String> images = {
    'B': 'assets/images/undosh/baliq.jpg',
    'D': 'assets/images/undosh/daryo.jpg',
    'F': 'assets/images/undosh/futbol.jpg',
    'G': 'assets/images/undosh/gul.jpg',
    'H': 'assets/images/undosh/haydovchi.jpg',
  };

  final Map<String, String> letterSounds = {
    'B': 'musics/b.mp3',
    'D': 'musics/d.mp3',
    'F': 'musics/f.mp3',
    'G': 'musics/g.mp3',
    'H': 'musics/h.mp3',
  };

  final Map<String, String> imageSounds = {
    'B': 'musics/baliq.mp3',
    'D': 'musics/daryo.mp3',
    'F': 'musics/futbol.mp3',
    'G': 'musics/gul.mp3',
    'H': 'musics/haydovchi.mp3',
  };

  final List<Color> bgColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
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
    final letter = consonants[currentIndex];
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
          "Undosh harfni o'rganing!",
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
                        if (currentIndex < consonants.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Tabriklaymiz! 🎉"),
                              content: const Text(
                                "Siz barcha undosh harflarni muvaffaqiyatli ko'rdigiz!",
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
                        currentIndex < consonants.length - 1
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
