import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  int _unreadCount = 0;

  // Mock user data for development
  final Map<String, dynamic>? _userData = {
    'name': 'John Doe',
    'email': 'john@example.com',
    'phone': '+91 9876543210',
    'address': '123 Main Street, City, State 12345',
  };

  // Mock current user for development
  final _currentUser = MockUser(
    uid: 'mock-user-id',
    email: 'john@example.com',
  );

  // Getters
  bool get isAuthenticated => false; // Mock as not authenticated
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get unreadCount => _unreadCount;
  bool get isAdmin => false;

  // Add missing getters for booking form
  MockUser? get currentUser => _currentUser;
  Map<String, dynamic>? get userData => _userData;

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

// Mock User class to simulate Firebase User
class MockUser {
  final String uid;
  final String? email;
  
  MockUser({required this.uid, this.email});
} 