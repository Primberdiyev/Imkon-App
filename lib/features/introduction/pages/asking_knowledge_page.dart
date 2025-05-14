import 'package:flutter/material.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/core/ui_kit/custom_network_item.dart';
import 'package:imkon/features/auth/pages/register_page.dart';
import 'package:imkon/features/utils/app_images.dart';

class AskingKnowledgePage extends StatefulWidget {
  const AskingKnowledgePage({super.key});

  @override
  State<AskingKnowledgePage> createState() => _AskingKnowledgePageState();
}

class _AskingKnowledgePageState extends State<AskingKnowledgePage> {
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
                height: 70,
                width: 220,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFAAB0B7)),
                ),
                child: const Text(
                  'Bilim darajangiz qanday?',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomNetworkItem(
            text: 'Bu sohada yangiman',
            imagePath: AppImages.beginner,
            isSelected: selectedItem == 'Bu sohada yangiman',
            onTap: () => selectItem('Bu sohada yangiman'),
          ),
          CustomNetworkItem(
            text: 'Boshlang\'ich bilimlarga \negaman',
            imagePath: AppImages.preLevel,
            isSelected: selectedItem == 'Boshlang\'ich bilimlarga \negaman',
            onTap: () => selectItem('Boshlang\'ich bilimlarga \negaman'),
          ),
          CustomNetworkItem(
            text: 'Asosiy bilimlarga egaman',
            imagePath: AppImages.middleLevel,
            isSelected: selectedItem == 'Asosiy bilimlarga egaman',
            onTap: () => selectItem('Asosiy bilimlarga egaman'),
          ),
          CustomNetworkItem(
            text: 'Mustahkam bilimgan \negaman',
            imagePath: AppImages.expert,
            isSelected: selectedItem == 'Mustahkam bilimgan \negaman',
            onTap: () => selectItem('Mustahkam bilimgan \negaman'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
        child: CustomButton(
          function:
              selectedItem != null
                  ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  }
                  : null,
          text: 'Davom Ettirish',
          textSize: 24,
          buttonColor: selectedItem != null ? Colors.purple : Colors.grey,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
