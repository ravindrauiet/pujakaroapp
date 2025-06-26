import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  int _unreadCount = 0;

  // Getters
  bool get isAuthenticated => false; // Mock as not authenticated
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get unreadCount => _unreadCount;
  bool get isAdmin => false;

  AuthService() {
    // Initialize with some demo data
    _unreadCount = 2;
  }

  // Sign in with email and password - mock implementation
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    _setLoading(false);
    return false;
  }

  // Sign out - mock implementation
  Future<void> signOut() async {
    _setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
} 