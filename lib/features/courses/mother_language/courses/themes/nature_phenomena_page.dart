import 'package:flutter/material.dart';
import 'package:imkon/features/courses/mother_language/courses/themes/nature_cateogry_page.dart';

class NaturePhenomenaMatchPage extends StatefulWidget {
  const NaturePhenomenaMatchPage({super.key});

  @override
  State<NaturePhenomenaMatchPage> createState() =>
      _NaturePhenomenaMatchPageState();
}

class _NaturePhenomenaMatchPageState extends State<NaturePhenomenaMatchPage> {
  String? selectedPhenomenonText;
  String? matchedPhenomenon;

  final List<Map<String, String>> phenomena = [
    {"name": "Yomg'ir", "image": "assets/images/nature/rain.jpg"},
    {"name": "Bo'ron", "image": "assets/images/nature/storm.jpg"},
    {"name": "Zilzila", "image": "assets/images/nature/earthquake.jpg"},
    {
      "name": "Quyosh tutilishi",
      "image": "assets/images/nature/solar_eclipse.jpg",
    },
  ];

  void checkMatch(String imagePhenomenon) {
    if (selectedPhenomenonText == null) return;

    if (selectedPhenomenonText == imagePhenomenon) {
      setState(() {
        matchedPhenomenon = imagePhenomenon;
        selectedPhenomenonText = null;
      });
      showSnackBar("To'g'ri! 👏", Colors.green);
    } else {
      setState(() {
        matchedPhenomenon = null;
        selectedPhenomenonText = null;
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
    phenomena.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tabiat Xodisalarini Moslang"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Tabiat xodisasini tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children:
                  phenomena.map((phenomenon) {
                    final isSelected =
                        selectedPhenomenonText == phenomenon["name"];
                    return ChoiceChip(
                      label: Text(
                        phenomenon["name"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.tealAccent.shade100,
                      onSelected: (_) {
                        setState(() {
                          selectedPhenomenonText = phenomenon["name"];
                        });
                      },
                      backgroundColor: Colors.cyan.shade100,
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
                    phenomena.map((phenomenon) {
                      final name = phenomenon["name"]!;
                      final image = phenomenon["image"]!;
                      final isMatched = matchedPhenomenon == name;

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
                            border: Border.all(color: Colors.teal, width: 2),
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
                    builder: (context) => NatureCategoryMatchPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
