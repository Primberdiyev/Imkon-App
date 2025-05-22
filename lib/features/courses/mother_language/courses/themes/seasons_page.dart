import 'package:flutter/material.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/season_match.dart';

class SeasonsPage extends StatefulWidget {
  const SeasonsPage({super.key});

  @override
  State<SeasonsPage> createState() => _SeasonMatchPageState();
}

class _SeasonMatchPageState extends State<SeasonsPage> {
  String? selectedSeasonText;
  String? matchedSeason;

  final List<Map<String, String>> seasons = [
    {"name": "Bahor", "image": "assets/images/spring.jpg"},
    {"name": "Yoz", "image": "assets/images/summer.jpg"},
    {"name": "Kuz", "image": "assets/images/autumn.jpg"},
    {"name": "Qish", "image": "assets/images/winter.jpg"},
  ];

  void checkMatch(String imageSeason) {
    if (selectedSeasonText == null) return;

    if (selectedSeasonText == imageSeason) {
      setState(() {
        matchedSeason = imageSeason;
        selectedSeasonText = null;
      });
      showSnackBar("To‘g‘ri! 👏", Colors.green);
    } else {
      setState(() {
        matchedSeason = null;
        selectedSeasonText = null;
      });
      showSnackBar("Noto‘g‘ri. Qaytadan urinib ko‘r! ❌", Colors.redAccent);
    }
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 18)),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    seasons.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Fasllarni moslang"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "So‘zni tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children:
                  seasons.map((season) {
                    final isSelected = selectedSeasonText == season["name"];
                    return ChoiceChip(
                      label: Text(
                        season["name"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.deepPurpleAccent.shade100,
                      onSelected: (_) {
                        setState(() {
                          selectedSeasonText = season["name"];
                        });
                      },
                      backgroundColor: Colors.purple.shade100,
                      labelStyle: const TextStyle(color: Colors.black),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              "Tegishli rasmni tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children:
                    seasons.map((season) {
                      final name = season["name"]!;
                      final image = season["image"]!;
                      final isMatched = matchedSeason == name;

                      return GestureDetector(
                        onTap: () => checkMatch(name),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color:
                                isMatched
                                    ? Colors.greenAccent.shade100
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.deepPurpleAccent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            image,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeasonMonthMatchPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Keyingi',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'myFirstFont',
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
