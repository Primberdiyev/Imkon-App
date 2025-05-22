import 'package:flutter/material.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/sport_category_page.dart';

class SportsMatchPage extends StatefulWidget {
  const SportsMatchPage({super.key});

  @override
  State<SportsMatchPage> createState() => _SportsMatchPageState();
}

class _SportsMatchPageState extends State<SportsMatchPage> {
  String? selectedSportText;
  String? matchedSport;

  final List<Map<String, String>> sports = [
    {"name": "Futbol", "image": "assets/images/sports/football.jpg"},
    {"name": "Basketbol", "image": "assets/images/sports/basketball.jpg"},
    {"name": "Tennis", "image": "assets/images/sports/tennis.jpg"},
    {"name": "Suzish", "image": "assets/images/sports/swimming.jpg"},
  ];

  void checkMatch(String imageSport) {
    if (selectedSportText == null) return;

    if (selectedSportText == imageSport) {
      setState(() {
        matchedSport = imageSport;
        selectedSportText = null;
      });
      showSnackBar("To'g'ri! 👏", Colors.green);
    } else {
      setState(() {
        matchedSport = null;
        selectedSportText = null;
      });
      showSnackBar("Noto'g'ri. Qaytadan urinib ko'ring! ❌", Colors.redAccent);
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
    sports.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sport Turlarini Moslang"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Sport turini tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children:
                  sports.map((sport) {
                    final isSelected = selectedSportText == sport["name"];
                    return ChoiceChip(
                      label: Text(
                        sport["name"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.redAccent.shade100,
                      onSelected: (_) {
                        setState(() {
                          selectedSportText = sport["name"];
                        });
                      },
                      backgroundColor: Colors.orange.shade100,
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
                    sports.map((sport) {
                      final name = sport["name"]!;
                      final image = sport["image"]!;
                      final isMatched = matchedSport == name;

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
                            border: Border.all(color: Colors.red, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              image,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
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
                    builder: (context) => SportCategoryMatchPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(150, 60),
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
