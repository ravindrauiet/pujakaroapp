import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool _isLoading = false;
  String _errorMessage = '';
  UserModel? _currentUser;
  int _unreadCount = 0;

  // Getters
  bool get isAuthenticated => _auth.currentUser != null;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get unreadCount => _unreadCount;
  bool get isAdmin => _currentUser?.isAdmin ?? false;
  UserModel? get currentUser => _currentUser;
  User? get firebaseUser => _auth.currentUser;
  
  // Add userData getter for backward compatibility with existing code
  Map<String, dynamic>? get userData {
    if (_currentUser == null) return null;
    return {
      'name': _currentUser!.name,
      'email': _currentUser!.email,
      'phone': _currentUser!.phone,
      'address': _currentUser!.address,
    };
  }

  AuthService() {
    _initAuthStateListener();
  }

  void _initAuthStateListener() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _loadUserData(user.uid);
      } else {
        _currentUser = null;
        _unreadCount = 0;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data()!, uid);
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  // Sign up with email and password
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      // Create user with Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) throw Exception('Failed to create user');
      
      // Create user profile in Firestore
      final userData = UserModel(
        uid: user.uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
        createdAt: DateTime.now(),
      );
      
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userData.toMap());
      
      _currentUser = userData;
      _setLoading(false);
      notifyListeners();
      
      return userData;
    } on FirebaseAuthException catch (e) {
      _setError(_getErrorMessage(e.code));
      _setLoading(false);
      return null;
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return null;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) throw Exception('Failed to sign in');
      
      // Load user data from Firestore
      await _loadUserData(user.uid);
      
      _setLoading(false);
      notifyListeners();
      
      return _currentUser;
    } on FirebaseAuthException catch (e) {
      _setError(_getErrorMessage(e.code));
      _setLoading(false);
      return null;
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      await _auth.signOut();
      _currentUser = null;
      _unreadCount = 0;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out');
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    String? name,
    String? phone,
    String? address,
  }) async {
    if (_currentUser == null) return false;
    
    try {
      final updates = <String, dynamic>{
        'updatedAt': DateTime.now(),
      };
      
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      if (address != null) updates['address'] = address;
      
      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .update(updates);
      
      // Update local user data
      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        phone: phone ?? _currentUser!.phone,
        address: address ?? _currentUser!.address,
        updatedAt: DateTime.now(),
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update profile');
      return false;
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later';
      default:
        return 'Authentication failed';
    }
  }
} 