import 'package:flutter/material.dart';
import '../db_helper/user_db_helper.dart';

class AuthProvider extends ChangeNotifier {
  final UserDatabaseHelper _userDatabase = UserDatabaseHelper();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> addUser(String username, String password) async {
    await _userDatabase.insertUser(username, password);
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    Map<String, dynamic>? user = await _userDatabase.getUser(username);

    if (user != null && user['password'] == password) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    return _isLoggedIn;
  }
}
