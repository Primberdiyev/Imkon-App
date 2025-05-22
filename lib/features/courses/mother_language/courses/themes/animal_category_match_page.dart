import 'package:flutter/material.dart';

class AnimalCategoryMatchPage extends StatefulWidget {
  const AnimalCategoryMatchPage({super.key});

  @override
  State<AnimalCategoryMatchPage> createState() =>
      _AnimalCategoryMatchPageState();
}

class _AnimalCategoryMatchPageState extends State<AnimalCategoryMatchPage> {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Yovvoyi hayvonlar",
      "image": "assets/images/animals/wild_animals.jpg",
      "animals": ["Sher", "Ayiq", "Fil", "Bo'ri"],
    },
    {
      "name": "Uy hayvonlari",
      "image": "assets/images/animals/pets.jpg",
      "animals": ["Mushuk", "It", "Quyon", "To'ng'iz"],
    },
    {
      "name": "Qushlar",
      "image": "assets/images/animals/birds.jpg",
      "animals": ["Burgut", "Laylak", "Kaptar", "Tovuq"],
    },
    {
      "name": "Suv hayvonlari",
      "image": "assets/images/animals/aquatic.jpg",
      "animals": ["Delfin", "Akula", "Timsah", "Baliq"],
    },
  ];

  int currentCategoryIndex = 0;

  // Har bir kategoriya uchun tanlangan hayvonlar
  Map<String, List<String>> userSelections = {
    "Yovvoyi hayvonlar": [],
    "Uy hayvonlari": [],
    "Qushlar": [],
    "Suv hayvonlari": [],
  };

  List<String> allAnimals = [
    "Sher",
    "Ayiq",
    "Fil",
    "Bo'ri",
    "Mushuk",
    "It",
    "Quyon",
    "To'ng'iz",
    "Burgut",
    "Laylak",
    "Kaptar",
    "Tovuq",
    "Delfin",
    "Akula",
    "Timsah",
    "Baliq",
  ];

  void onAnimalSelected(String animal) {
    final currentCategoryName = categories[currentCategoryIndex]["name"];

    if ((userSelections[currentCategoryName] ?? []).contains(animal)) return;

    setState(() {
      userSelections[currentCategoryName]?.add(animal);
    });

    if (userSelections[currentCategoryName]?.length == 4) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          if (currentCategoryIndex < categories.length - 1) {
            setState(() {
              currentCategoryIndex++;
            });
          } else {
            showResultsDialog();
          }
        }
      });
    }
  }

  bool isAnimalDisabled(String animal) {
    for (int i = 0; i < currentCategoryIndex; i++) {
      if ((userSelections[categories[i]["name"]] ?? []).contains(animal)) {
        return true;
      }
    }
    return false;
  }

  void showResultsDialog() {
    Map<String, List<String>> correctSelections = {};
    Map<String, List<String>> wrongSelections = {};

    for (var category in categories) {
      final name = category["name"];
      final correctAnimals = List<String>.from(category["animals"]);
      final userAnimals = userSelections[name] ?? [];

      correctSelections[name] =
          userAnimals.where((a) => correctAnimals.contains(a)).toList();
      wrongSelections[name] =
          userAnimals.where((a) => !correctAnimals.contains(a)).toList();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Natijalar"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  categories.map((category) {
                    final name = category["name"];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$name:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "To'g'ri tanlangan hayvonlar: ${correctSelections[name] ?? [].join(", ")}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Noto'g'ri tanlangan hayvonlar: ${wrongSelections[name] ?? [].join(", ")}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(150, 60),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Bosh sahifaga",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'myFirstFont',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = categories[currentCategoryIndex];
    final currentCategoryName = currentCategory["name"];

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Hayvon Kategoriyalari"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              currentCategoryName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 12),
            Image.asset(
              currentCategory["image"],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              "Hayvonlarni tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children:
                    allAnimals.map((animal) {
                      final disabled = isAnimalDisabled(animal);
                      final isSelected = (userSelections[currentCategoryName] ??
                              [])
                          .contains(animal);

                      return GestureDetector(
                        onTap: disabled ? null : () => onAnimalSelected(animal),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color:
                                disabled
                                    ? Colors.grey.shade300
                                    : (isSelected
                                        ? Colors.greenAccent.shade200
                                        : Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  disabled
                                      ? Colors.grey
                                      : (isSelected
                                          ? Colors.green
                                          : Colors.grey.shade400),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              animal,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    disabled
                                        ? Colors.grey
                                        : (isSelected
                                            ? Colors.black
                                            : Colors.black87),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${userSelections[currentCategoryName]?.length} / 4 tanlandi",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
