import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all pujas
  Future<List<Map<String, dynamic>>> getAllPujas() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('pujas').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching pujas: $e');
      return [];
    }
  }

  // Get puja by ID
  Future<Map<String, dynamic>?> getPujaById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('pujas').doc(id).get();
      
      if (doc.exists) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }
      
      return null;
    } catch (e) {
      debugPrint('Error fetching puja by ID: $e');
      return null;
    }
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('products').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching products: $e');
      return [];
    }
  }

  // Get product by ID
  Future<Map<String, dynamic>?> getProductById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('products').doc(id).get();
      
      if (doc.exists) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }
      
      return null;
    } catch (e) {
      debugPrint('Error fetching product by ID: $e');
      return null;
    }
  }

  // Get all pandits
  Future<List<Map<String, dynamic>>> getAllPandits() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('pandits').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching pandits: $e');
      return [];
    }
  }

  // Get featured pujas
  Future<List<Map<String, dynamic>>> getFeaturedPujas() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('pujas')
          .where('featured', isEqualTo: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching featured pujas: $e');
      return [];
    }
  }

  // Get featured products
  Future<List<Map<String, dynamic>>> getFeaturedProducts() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('featured', isEqualTo: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching featured products: $e');
      return [];
    }
  }

  // Get testimonials
  Future<List<Map<String, dynamic>>> getTestimonials() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('testimonials').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching testimonials: $e');
      return [];
    }
  }

  // Get blog posts
  Future<List<Map<String, dynamic>>> getBlogPosts() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('blogs')
          .orderBy('publishedAt', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching blog posts: $e');
      return [];
    }
  }

  // Get blog post by ID
  Future<Map<String, dynamic>?> getBlogPostById(String id) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('blogs').doc(id).get();
      
      if (doc.exists) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }
      
      return null;
    } catch (e) {
      debugPrint('Error fetching blog post by ID: $e');
      return null;
    }
  }

  // Get user bookings
  Future<List<Map<String, dynamic>>> getUserBookings(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('bookingDate', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching user bookings: $e');
      return [];
    }
  }

  // Get user orders
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
      
    } catch (e) {
      debugPrint('Error fetching user orders: $e');
      return [];
    }
  }
} 