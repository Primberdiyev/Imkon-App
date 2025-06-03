import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/core/ui_kit/custom_network_item.dart';
import 'package:imkon/features/introduction/pages/asking_knowledge_page.dart';
import 'package:imkon/features/utils/app_images.dart';

class AskingWherePage extends StatefulWidget {
  const AskingWherePage({super.key});

  @override
  State<AskingWherePage> createState() => _AskingWherePageState();
}

class _AskingWherePageState extends State<AskingWherePage> {
  String? selectedItem;

  void selectItem(String item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AppImages.bird, width: 80, height: 80),
              Container(
                height: 100,
                width: 250,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFAAB0B7)),
                ),
                child: const Text(
                  'Imkon ilovasi haqida qayerdan eshitdingiz?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomNetworkItem(
            text: 'Telegram',
            imagePath: AppImages.telegram,
            isSelected: selectedItem == 'Telegram',
            onTap: () => selectItem('Telegram'),
          ),
          CustomNetworkItem(
            text: 'Youtube',
            imagePath: AppImages.youtube,
            isSelected: selectedItem == 'Youtube',
            onTap: () => selectItem('Youtube'),
          ),
          CustomNetworkItem(
            text: 'Instagram',
            imagePath: AppImages.instagram,
            isSelected: selectedItem == 'Instagram',
            onTap: () => selectItem('Instagram'),
          ),
          CustomNetworkItem(
            text: "Do'stlar",
            imagePath: AppImages.friends,
            isSelected: selectedItem == "Do'stlar",
            onTap: () => selectItem("Do'stlar"),
          ),
          CustomNetworkItem(
            text: "Boshqa",
            imagePath: AppImages.other,
            isSelected: selectedItem == "Boshqa",
            onTap: () => selectItem("Boshqa"),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 30, right: 30),
        child: CustomButton(
          function: selectedItem != null
              ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AskingKnowledgePage(),
                    ),
                  );
                }
              : null,
          text: 'Davom Ettirish',
          textSize: 24,
          buttonColor: selectedItem != null ? Color(0xFFFFD700) : Colors.grey,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
