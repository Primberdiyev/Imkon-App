import 'package:flutter/material.dart';

class NatureCategoryMatchPage extends StatefulWidget {
  const NatureCategoryMatchPage({super.key});

  @override
  State<NatureCategoryMatchPage> createState() =>
      _NatureCategoryMatchPageState();
}

class _NatureCategoryMatchPageState extends State<NatureCategoryMatchPage> {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Atmosfera hodisalari",
      "image": "assets/images/nature/atmosphere.jpg",
      "phenomena": ["Yomg'ir", "Bo'ron", "Momaqaldiroq", "Tuman"],
    },
    {
      "name": "Yer osti hodisalari",
      "image": "assets/images/nature/underground.jpg",
      "phenomena": [
        "Zilzila",
        "Vulkan otilishi",
        "Tuproq siljishi",
        "G'or hosil bo'lishi",
      ],
    },
    {
      "name": "Suv hodisalari",
      "image": "assets/images/nature/water.jpg",
      "phenomena": ["To'fon", "Tsunami", "Suv toshqini", "Muzlik erishi"],
    },
    {
      "name": "Kosmik hodisalar",
      "image": "assets/images/nature/space.jpg",
      "phenomena": [
        "Quyosh tutilishi",
        "Oy tutilishi",
        "Meteor yomg'iri",
        "Kometa",
      ],
    },
  ];

  int currentCategoryIndex = 0;

  // Har bir kategoriya uchun tanlangan hodisalar
  Map<String, List<String>> userSelections = {
    "Atmosfera hodisalari": [],
    "Yer osti hodisalari": [],
    "Suv hodisalari": [],
    "Kosmik hodisalar": [],
  };

  List<String> allPhenomena = [
    "Yomg'ir",
    "Bo'ron",
    "Momaqaldiroq",
    "Tuman",
    "Zilzila",
    "Vulkan otilishi",
    "Tuproq siljishi",
    "G'or hosil bo'lishi",
    "To'fon",
    "Tsunami",
    "Suv toshqini",
    "Muzlik erishi",
    "Quyosh tutilishi",
    "Oy tutilishi",
    "Meteor yomg'iri",
    "Kometa",
  ];

  void onPhenomenonSelected(String phenomenon) {
    final currentCategoryName = categories[currentCategoryIndex]["name"];

    if (userSelections[currentCategoryName]!.contains(phenomenon)) return;

    setState(() {
      userSelections[currentCategoryName]!.add(phenomenon);
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

  bool isPhenomenonDisabled(String phenomenon) {
    for (int i = 0; i < currentCategoryIndex; i++) {
      if (userSelections[categories[i]["name"]]!.contains(phenomenon)) {
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
      final correctPhenomena = List<String>.from(category["phenomena"]);
      final userPhenomena = userSelections[name]!;

      correctSelections[name] =
          userPhenomena.where((p) => correctPhenomena.contains(p)).toList();
      wrongSelections[name] =
          userPhenomena.where((p) => !correctPhenomena.contains(p)).toList();
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
                          "To'g'ri tanlangan hodisalar: ${correctSelections[name]!.join(", ")}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Noto'g'ri tanlangan hodisalar: ${wrongSelections[name]!.join(", ")}",
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
                  backgroundColor: Colors.teal,
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
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Tabiat Kategoriyalari"),
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
                color: Colors.blueGrey,
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
              "Tabiat hodisalarini tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children:
                    allPhenomena.map((phenomenon) {
                      final disabled = isPhenomenonDisabled(phenomenon);
                      final isSelected = userSelections[currentCategoryName]!
                          .contains(phenomenon);

                      return GestureDetector(
                        onTap:
                            disabled
                                ? null
                                : () => onPhenomenonSelected(phenomenon),
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
                              phenomenon,
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
