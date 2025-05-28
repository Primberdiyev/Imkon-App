import 'package:flutter/material.dart';
import 'package:imkon/core/services/hive_service.dart';
import 'package:imkon/features/auth/models/user_model.dart';
import 'package:imkon/features/profile/providers/profile_provider.dart';
import 'package:imkon/features/utils/app_images.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String monthYear = "Aprel 2025";

  @override
  void initState() {
    super.initState();
    final userModel = HiveService.getUserModel();
    if (userModel?.time != null) {
      DateTime savedTime =
          userModel?.time ?? DateTime.now().add(const Duration(days: -30));
      monthYear = DateFormat('MMMM yyyy', 'uz').format(savedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          final userModel = provider.userModel ?? HiveService.getUserModel();

          return ListView(
            padding: const EdgeInsets.all(30),
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.orangeAccent.withAlpha(50),
                  radius: 75,
                  backgroundImage: provider.profileImage != null
                      ? FileImage(provider.profileImage!)
                      : null,
                  child: provider.profileImage == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.black.withAlpha(128),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () => provider.pickImage(),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    margin: const EdgeInsets.only(bottom: 30),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withAlpha(50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/edit_text.png',
                          color: Colors.orangeAccent,
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          "Rasimni o'zgartirish",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userModel?.name ?? "Dilshodbek",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'myFirstFont',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    userModel?.surname ?? "Primberdiyevv",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'myFirstFont',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Qo'shilgan:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    monthYear,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Faollik',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/images/clock.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sarflangan'),
                          Text(
                            '20 daqiqa',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Kurslarim',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 90) / 2,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withAlpha(50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 100,
                    margin: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.tools,
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          'Matematika',
                          style: TextStyle(
                            fontFamily: 'myFirstFont',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 90) / 2,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withAlpha(50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 100,
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/books.png',
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          'Ona Tili',
                          style: TextStyle(
                            fontFamily: 'myFirstFont',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
