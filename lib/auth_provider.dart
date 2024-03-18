import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unauthenticated;

  AuthStatus get status => _status;

  AuthProvider() {
    _getStatusFromLocalStorage();
  }

  Future<void> signIn(String username, String password) async {
    _status = AuthStatus.authenticated;
    notifyListeners();

    await _saveStatusToLocalStorage();
  }

  Future<void> signOut() async {
    _status = AuthStatus.unauthenticated;
    notifyListeners();

    await _removeStatusFromLocalStorage();
  }

  Future<void> _getStatusFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getString('authStatus');

    if (status == 'authenticated') {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
  }

  Future<void> _saveStatusToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authStatus', 'authenticated');
  }

  Future<void> _removeStatusFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authStatus');
  }
}
