import 'package:flutter/material.dart';

class SportCategoryMatchPage extends StatefulWidget {
  const SportCategoryMatchPage({super.key});

  @override
  State<SportCategoryMatchPage> createState() => _SportCategoryMatchPageState();
}

class _SportCategoryMatchPageState extends State<SportCategoryMatchPage> {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Jamoa sportlari",
      "image": "assets/images/sports/team_sports.jpg",
      "sports": ["Futbol", "Basketbol", "Voleybol", "Xokkey"],
    },
    {
      "name": "Individual sportlar",
      "image": "assets/images/sports/individual.jpg",
      "sports": ["Tennis", "Boks", "Gimnastika", "Yengil atletika"],
    },
    {
      "name": "Qishki sportlar",
      "image": "assets/images/sports/winter.jpg",
      "sports": ["Chang'i", "Konki", "Snoubord", "Xokkey"],
    },
    {
      "name": "Suv sportlari",
      "image": "assets/images/sports/water.jpg",
      "sports": ["Suzish", "Sutga sakrash", "Aykido", "Kanoeda eshish"],
    },
  ];

  int currentCategoryIndex = 0;

  // Har bir kategoriya uchun tanlangan sport turlari
  Map<String, List<String>> userSelections = {
    "Jamoa sportlari": [],
    "Individual sportlar": [],
    "Qishki sportlar": [],
    "Suv sportlari": [],
  };

  List<String> allSports = [
    "Futbol",
    "Basketbol",
    "Voleybol",
    "Gandbol",
    "Tennis",
    "Boks",
    "Gimnastika",
    "Yengil atletika",
    "Chang'i",
    "Konki",
    "Snoubord",
    "Xokkey",
    "Suzish",
    "Sutga sakrash",
    "Aykido",
    "Kanoeda eshish",
  ];

  void onSportSelected(String sport) {
    final currentCategoryName = categories[currentCategoryIndex]["name"];

    if (userSelections[currentCategoryName]!.contains(sport)) return;

    setState(() {
      userSelections[currentCategoryName]!.add(sport);
    });

    if (userSelections[currentCategoryName]!.length == 4) {
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

  bool isSportDisabled(String sport) {
    for (int i = 0; i < currentCategoryIndex; i++) {
      if (userSelections[categories[i]["name"]]!.contains(sport)) {
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
      final correctSports = List<String>.from(category["sports"]);
      final userSports = userSelections[name]!;

      correctSelections[name] =
          userSports.where((s) => correctSports.contains(s)).toList();
      wrongSelections[name] =
          userSports.where((s) => !correctSports.contains(s)).toList();
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
                          "To'g'ri tanlangan sportlar: ${correctSelections[name]!.join(", ")}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Noto'g'ri tanlangan sportlar: ${wrongSelections[name]!.join(", ")}",
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
                  backgroundColor: Colors.red,
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
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Sport Kategoriyalari",
          style: TextStyle(color: Colors.white),
        ),
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
                fontSize: 28,
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
              "Sport turlarini tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children:
                    allSports.map((sport) {
                      final disabled = isSportDisabled(sport);
                      final isSelected = userSelections[currentCategoryName]!
                          .contains(sport);

                      return GestureDetector(
                        onTap: disabled ? null : () => onSportSelected(sport),
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
                              sport,
                              style: TextStyle(
                                fontSize: 14,
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
              "${userSelections[currentCategoryName]!.length} / 4 tanlandi",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
