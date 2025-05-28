import 'package:flutter/material.dart';
import 'package:imkon/core/services/hive_service.dart';
import 'package:imkon/features/auth/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> checkAuthStatus() async {
    try {
      final users = HiveService.userBox.values.toList();
      if (users.isNotEmpty) {
        _currentUser = users.last;
      } else {
        _currentUser = null;
      }
      Future.microtask(() => notifyListeners());
    } catch (e) {
      _currentUser = null;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> logout() async {
    await HiveService.userBox.clear();
    _currentUser = null;
    Future.microtask(() => notifyListeners());
  }
}
