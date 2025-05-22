import 'package:flutter/material.dart';

class SeasonMonthMatchPage extends StatefulWidget {
  const SeasonMonthMatchPage({super.key});

  @override
  State<SeasonMonthMatchPage> createState() => _SeasonMonthMatchPageState();
}

class _SeasonMonthMatchPageState extends State<SeasonMonthMatchPage> {
  final List<Map<String, dynamic>> seasons = [
    {
      "name": "Bahor",
      "image": "assets/images/spring.jpg",
      "months": ["Mart", "Aprel", "May"],
    },
    {
      "name": "Yoz",
      "image": "assets/images/summer_1.jpg",
      "months": ["Iyun", "Iyul", "Avgust"],
    },
    {
      "name": "Kuz",
      "image": "assets/images/autumn.jpg",
      "months": ["Sentyabr", "Oktyabr", "Noyabr"],
    },
    {
      "name": "Qish",
      "image": "assets/images/winter.jpg",
      "months": ["Dekabr", "Yanvar", "Fevral"],
    },
  ];

  int currentSeasonIndex = 0;

  // Har fasl uchun tanlangan oylar
  Map<String, List<String>> userSelections = {
    "Bahor": [],
    "Yoz": [],
    "Kuz": [],
    "Qish": [],
  };

  List<String> allMonths = [
    "Yanvar",
    "Fevral",
    "Dekabr",
    "Mart",
    "Iyul",
    "Noyabr",
    "May",
    "Iyun",
    "Avgust",
    "Aprel",
    "Sentyabr",
    "Oktyabr",
  ];

  void onMonthSelected(String month) {
    final currentSeasonName = seasons[currentSeasonIndex]["name"];

    if (userSelections[currentSeasonName]!.contains(month)) return;

    setState(() {
      userSelections[currentSeasonName]!.add(month);
    });

    if (userSelections[currentSeasonName]!.length == 3) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          if (currentSeasonIndex < seasons.length - 1) {
            setState(() {
              currentSeasonIndex++;
            });
          } else {
            showResultsDialog();
          }
        }
      });
    }
  }

  bool isMonthDisabled(String month) {
    for (int i = 0; i < currentSeasonIndex; i++) {
      if (userSelections[seasons[i]["name"]]!.contains(month)) {
        return true;
      }
    }
    return false;
  }

  void showResultsDialog() {
    Map<String, List<String>> correctSelections = {};
    Map<String, List<String>> wrongSelections = {};

    for (var season in seasons) {
      final name = season["name"];
      final correctMonths = List<String>.from(season["months"]);
      final userMonths = userSelections[name]!;

      correctSelections[name] =
          userMonths.where((m) => correctMonths.contains(m)).toList();
      wrongSelections[name] =
          userMonths.where((m) => !correctMonths.contains(m)).toList();
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
                  seasons.map((season) {
                    final name = season["name"];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$name fasli:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "To'g'ri tanlangan oylar: ${correctSelections[name]!.join(", ")}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Noto'g'ri tanlangan oylar: ${wrongSelections[name]!.join(", ")}",
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
                  fixedSize: Size(150, 60),
                  backgroundColor: Colors.blue,
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
    final currentSeason = seasons[currentSeasonIndex];
    final currentSeasonName = currentSeason["name"];

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Fasl va Oylarni Moslash"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              currentSeasonName,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            Image.asset(
              currentSeason["image"],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              "Oylarni tanlang:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children:
                    allMonths.map((month) {
                      final disabled = isMonthDisabled(month);
                      final isSelected = userSelections[currentSeasonName]!
                          .contains(month);

                      return GestureDetector(
                        onTap: disabled ? null : () => onMonthSelected(month),
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
                              month,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    disabled
                                        ? Colors.grey
                                        : (isSelected
                                            ? Colors.black
                                            : Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${userSelections[currentSeasonName]!.length} / 3 tanlandi",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
