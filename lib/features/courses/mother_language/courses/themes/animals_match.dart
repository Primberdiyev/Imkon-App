import 'package:flutter/material.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/animal_category_match_page.dart';

class AnimalsMatchPage extends StatefulWidget {
  const AnimalsMatchPage({super.key});

  @override
  State<AnimalsMatchPage> createState() => _AnimalsMatchPageState();
}

class _AnimalsMatchPageState extends State<AnimalsMatchPage> {
  String? selectedAnimalText;
  String? matchedAnimal;

  final List<Map<String, String>> animals = [
    {"name": "Sher", "image": "assets/images/animals/lion.jpg"},
    {"name": "Fil", "image": "assets/images/animals/elephant.jpg"},
    {"name": "Ayiq", "image": "assets/images/animals/bear.jpg"},
    {"name": "Bo'ri", "image": "assets/images/animals/wolf.jpg"},
  ];

  void checkMatch(String imageAnimal) {
    if (selectedAnimalText == null) return;

    if (selectedAnimalText == imageAnimal) {
      setState(() {
        matchedAnimal = imageAnimal;
        selectedAnimalText = null;
      });
      showSnackBar("To'g'ri! 👏", Colors.green);
    } else {
      setState(() {
        matchedAnimal = null;
        selectedAnimalText = null;
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
    animals.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hayvonlarni Moslang"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Hayvon nomini tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children:
                  animals.map((animal) {
                    final isSelected = selectedAnimalText == animal["name"];
                    return ChoiceChip(
                      label: Text(
                        animal["name"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.orangeAccent.shade100,
                      onSelected: (_) {
                        setState(() {
                          selectedAnimalText = animal["name"];
                        });
                      },
                      backgroundColor: Colors.amber.shade100,
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
                    animals.map((animal) {
                      final name = animal["name"]!;
                      final image = animal["image"]!;
                      final isMatched = matchedAnimal == name;

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
                            border: Border.all(color: Colors.orange, width: 2),
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
                    builder: (context) => AnimalCategoryMatchPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
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
