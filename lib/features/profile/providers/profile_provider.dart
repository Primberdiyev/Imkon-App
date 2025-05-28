import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imkon/features/auth/models/user_model.dart';
import 'package:imkon/core/services/hive_service.dart';

class ProfileProvider with ChangeNotifier {
  File? _profileImage;
  UserModel? _userModel;

  File? get profileImage => _profileImage;
  UserModel? get userModel => _userModel;

  ProfileProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userModel = HiveService.getUserModel();
    if (_userModel?.imagePath != null) {
      _profileImage = File(_userModel!.imagePath!);
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);

      final updatedUser = _userModel!.copyWith(
        imagePath: pickedFile.path,
      );

      final userBox = Hive.box<UserModel>('userBox');
      final index =
          userBox.values.toList().indexWhere((user) => user == _userModel);

      if (index != -1) {
        await HiveService.editUser(index, updatedUser);
        _userModel = updatedUser;
        notifyListeners();
      }
    }
  }
}
