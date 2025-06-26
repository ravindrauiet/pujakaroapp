import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Utility class for Firestore operations
class FirestoreUtils {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Collection references
  static final CollectionReference _productsCollection = _firestore.collection('products');
  static final CollectionReference _pujasCollection = _firestore.collection('pujas');
  static final CollectionReference _panditsCollection = _firestore.collection('pandits');
  
  /// Get all pujas from Firestore
  static Future<List<Map<String, dynamic>>> getAllPujas() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('pujas').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();
    } catch (e) {
      debugPrint('FirestoreUtils: Error getting pujas - $e');
      return [];
    }
  }
  
  /// Get a specific puja by ID
  static Future<Map<String, dynamic>?> getPujaById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('pujas').doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }
      return null;
    } catch (e) {
      debugPrint('FirestoreUtils: Error getting puja by id - $e');
      return null;
    }
  }
  
  /// Get all products from Firestore
  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();
    } catch (e) {
      debugPrint('FirestoreUtils: Error getting products - $e');
      return [];
    }
  }
  
  /// Get a specific product by ID
  static Future<Map<String, dynamic>?> getProductById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('products').doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }
      return null;
    } catch (e) {
      debugPrint('FirestoreUtils: Error getting product by id - $e');
      return null;
    }
  }
  
  /// Get all pandits from Firestore
  static Future<List<Map<String, dynamic>>> getAllPandits() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('pandits').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();
    } catch (e) {
      debugPrint('FirestoreUtils: Error getting pandits - $e');
      return [];
    }
  }
  
  /// Book a puja
  static Future<bool> bookPuja({
    required String pujaId, 
    required String userId,
    required String dateTime, 
    required String location,
    required String panditId,
    required double amount,
    Map<String, dynamic>? additionalDetails
  }) async {
    try {
      await _firestore.collection('bookings').add({
        'pujaId': pujaId,
        'userId': userId,
        'dateTime': dateTime,
        'location': location,
        'panditId': panditId,
        'amount': amount,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        ...?additionalDetails
      });
      return true;
    } catch (e) {
      debugPrint('FirestoreUtils: Error booking puja - $e');
      return false;
    }
  }
} 