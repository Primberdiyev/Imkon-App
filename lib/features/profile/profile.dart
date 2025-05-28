import 'package:flutter/material.dart';
import 'package:imkon/core/services/hive_service.dart';
import 'package:imkon/features/auth/models/user_model.dart';
import 'package:imkon/features/utils/app_images.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserModel? userModel;
  String monthYear = "Aprel 2025";

  @override
  void initState() {
    userModel = HiveService.getUserModel();
    if (userModel?.time != null) {
      DateTime savedTime =
          userModel?.time ?? DateTime.now().add(Duration(days: -30));
      monthYear = DateFormat('MMMM yyyy', 'uz').format(savedTime);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        SizedBox(
          height: 60,
        ),
        Center(
          child: Text(
            'Profil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.orangeAccent.withValues(alpha: 0.3),
            radius: 50,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 150,
            margin: EdgeInsets.only(bottom: 30),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withValues(alpha: 0.3),
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
            SizedBox(
              width: 10,
            ),
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
        SizedBox(
          height: 15,
        ),
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
            SizedBox(
              width: 10,
            ),
            Text(
              monthYear,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
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
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/clock.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
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
        SizedBox(
          height: 30,
        ),
        Text(
          'Kurslarim',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 90) / 2,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 100,
              margin: EdgeInsets.only(
                right: 15,
              ),
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
                color: Colors.blueGrey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 100,
              margin: EdgeInsets.only(
                left: 15,
              ),
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
  }
}
