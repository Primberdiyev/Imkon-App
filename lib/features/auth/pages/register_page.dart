import 'package:flutter/material.dart';
import 'package:imkon/core/services/hive_service.dart';
import 'package:imkon/core/ui_kit/custom_button.dart';
import 'package:imkon/core/ui_kit/custom_text_field.dart';
import 'package:imkon/features/auth/models/user_model.dart';
import 'package:imkon/features/home/pages/home_page.dart';
import 'package:imkon/features/utils/region_map.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();

  String? selectedRegion;
  String? selectedDistrict;

  List<String> get regions => regionMap.keys.toList();
  List<String> get districts =>
      selectedRegion == null ? [] : regionMap[selectedRegion]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ro'yxatdan o'tish"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(label: 'Ism', controller: nameController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomTextField(
                label: 'Familiya',
                controller: surnameController,
              ),
            ),
            CustomTextField(
              label: 'Yosh',
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Viloyatni tanlang'),
              value: selectedRegion,
              items: regions
                  .map(
                    (region) => DropdownMenuItem(
                      value: region,
                      child: Text(region),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null;
                });
              },
            ),
            if (selectedRegion != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tuman'),
                value: selectedDistrict,
                items: districts
                    .map(
                      (district) => DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => selectedDistrict = value),
              ),
            const SizedBox(height: 20),
            Spacer(),
            CustomButton(
              function: () {
                if (nameController.text.isNotEmpty &&
                    surnameController.text.isNotEmpty &&
                    ageController.text.isNotEmpty &&
                    selectedRegion != null &&
                    selectedDistrict != null) {
                  final user = UserModel(
                    name: nameController.text,
                    surname: surnameController.text,
                    age: ageController.text,
                    region: selectedRegion ?? 'Fergana',
                    district: selectedDistrict ?? "Toshloq",
                    time: DateTime.now(),
                  );
                  HiveService.saveUser(user);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
              text: 'Ro\'yxatdan o\'tish',
              textSize: 20,
              buttonColor: Color(0xFFFFD700),
              textColor: Colors.white,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
