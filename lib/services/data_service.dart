import 'package:flutter/foundation.dart';
import '../utils/firestore_utils.dart';

class DataService with ChangeNotifier {
  final bool useFirebase;

  DataService({this.useFirebase = true});

  // Mock data for pujas (fallback if Firestore fails)
  final List<Map<String, dynamic>> _fallbackPujas = [
    {
      'id': 'puja1',
      'name': 'Satyanarayan Puja',
      'description': 'A traditional Hindu ritual dedicated to Lord Vishnu.',
      'price': 1999.0,
      'image': 'puja1.jpg',
      'duration': '3 hours',
      'rating': 4.8,
      'reviews': 120,
      'featured': true,
    },
    {
      'id': 'puja2',
      'name': 'Ganesh Puja',
      'description': 'Ceremony to worship Lord Ganesha, the remover of obstacles.',
      'price': 1499.0,
      'image': 'puja2.jpg',
      'duration': '2 hours',
      'rating': 4.7,
      'reviews': 95,
      'featured': true,
    },
  ];

  // Mock data for products (fallback if Firestore fails)
  final List<Map<String, dynamic>> _fallbackProducts = [
    {
      'id': 'prod1',
      'name': 'Brass Diya Set',
      'description': 'Set of 5 traditional brass diyas for puja ceremonies.',
      'price': 599.0,
      'image': 'product1.jpg',
      'rating': 4.5,
      'reviews': 78,
      'featured': true,
      'category': 'Puja Items',
    },
    {
      'id': 'prod2',
      'name': 'Rudraksha Mala',
      'description': 'Sacred prayer beads made from Rudraksha seeds.',
      'price': 899.0,
      'image': 'product2.jpg',
      'rating': 4.9,
      'reviews': 45,
      'featured': true,
      'category': 'Jewelry',
    },
  ];

  // Mock data for pandits (fallback if Firestore fails)
  final List<Map<String, dynamic>> _fallbackPandits = [
    {
      'id': 'pandit1',
      'name': 'Acharya Sharma',
      'experience': '15+ years',
      'specialization': 'Vedic rituals',
      'image': 'pandit1.jpg',
      'rating': 4.9,
      'reviews': 210,
    },
    {
      'id': 'pandit2',
      'name': 'Pandit Mishra',
      'experience': '20+ years',
      'specialization': 'Vastu and Astrology',
      'image': 'pandit2.jpg',
      'rating': 4.8,
      'reviews': 185,
    },
  ];

  // Mock data for blogs
  final List<Map<String, dynamic>> _blogs = [
    {
      'id': 'blog1',
      'title': 'The Significance of Diwali',
      'content': 'Diwali, the festival of lights, is one of the most significant festivals in Hinduism...',
      'author': 'Acharya Sharma',
      'publishedAt': '2023-10-15',
      'image': 'blog1.jpg',
      'category': 'Festivals',
    },
    {
      'id': 'blog2',
      'title': 'Understanding Vedic Astrology',
      'content': 'Vedic astrology, also known as Jyotish, is the traditional Hindu system of astrology...',
      'author': 'Dr. Joshi',
      'publishedAt': '2023-09-28',
      'image': 'blog2.jpg',
      'category': 'Astrology',
    },
  ];

  // Mock data for testimonials
  final List<Map<String, dynamic>> _testimonials = [
    {
      'id': 'test1',
      'name': 'Rahul Sharma',
      'location': 'Mumbai',
      'content': 'The online puja service was excellent. The pandit was very knowledgeable and guided us through the entire process.',
      'rating': 5,
    },
    {
      'id': 'test2',
      'name': 'Priya Singh',
      'location': 'Delhi',
      'content': 'Great experience with PujaKaro. The products arrived on time and were of excellent quality.',
      'rating': 4,
    },
  ];

  // Get all pujas
  Future<List<Map<String, dynamic>>> getAllPujas() async {
    if (!useFirebase) {
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
      return _fallbackPujas;
    }
    
    try {
      // Try to get data from Firestore
      final pujas = await FirestoreUtils.getAllPujas();
      
      if (pujas.isNotEmpty) {
        debugPrint('Successfully fetched ${pujas.length} pujas from Firestore');
        return pujas;
      } else {
        debugPrint('No pujas found in Firestore, using fallback data');
        return _fallbackPujas;
      }
    } catch (e) {
      debugPrint('Error fetching pujas from Firestore: $e');
      debugPrint('Using fallback puja data');
      return _fallbackPujas;
    }
  }

  // Get puja by ID
  Future<Map<String, dynamic>?> getPujaById(String id) async {
    if (!useFirebase) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _fallbackPujas.firstWhere((puja) => puja['id'] == id, orElse: () => {});
    }
    
    try {
      // Try to get data from Firestore
      final puja = await FirestoreUtils.getPujaById(id);
      
      if (puja != null) {
        debugPrint('Successfully fetched puja with ID $id from Firestore');
        return puja;
      } else {
        debugPrint('No puja with ID $id found in Firestore, checking fallback data');
        return _fallbackPujas.firstWhere((puja) => puja['id'] == id, orElse: () => {});
      }
    } catch (e) {
      debugPrint('Error fetching puja with ID $id from Firestore: $e');
      debugPrint('Checking fallback puja data');
      return _fallbackPujas.firstWhere((puja) => puja['id'] == id, orElse: () => {});
    }
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    if (!useFirebase) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _fallbackProducts;
    }
    
    try {
      // Try to get data from Firestore
      final products = await FirestoreUtils.getAllProducts();
      
      if (products.isNotEmpty) {
        debugPrint('Successfully fetched ${products.length} products from Firestore');
        return products;
      } else {
        debugPrint('No products found in Firestore, using fallback data');
        return _fallbackProducts;
      }
    } catch (e) {
      debugPrint('Error fetching products from Firestore: $e');
      debugPrint('Using fallback product data');
      return _fallbackProducts;
    }
  }

  // Get product by ID
  Future<Map<String, dynamic>?> getProductById(String id) async {
    if (!useFirebase) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _fallbackProducts.firstWhere((product) => product['id'] == id, orElse: () => {});
    }
    
    try {
      // Try to get data from Firestore
      final product = await FirestoreUtils.getProductById(id);
      
      if (product != null) {
        debugPrint('Successfully fetched product with ID $id from Firestore');
        return product;
      } else {
        debugPrint('No product with ID $id found in Firestore, checking fallback data');
        return _fallbackProducts.firstWhere((product) => product['id'] == id, orElse: () => {});
      }
    } catch (e) {
      debugPrint('Error fetching product with ID $id from Firestore: $e');
      debugPrint('Checking fallback product data');
      return _fallbackProducts.firstWhere((product) => product['id'] == id, orElse: () => {});
    }
  }

  // Get all pandits
  Future<List<Map<String, dynamic>>> getAllPandits() async {
    if (!useFirebase) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _fallbackPandits;
    }
    
    try {
      // Try to get data from Firestore
      final pandits = await FirestoreUtils.getAllPandits();
      
      if (pandits.isNotEmpty) {
        debugPrint('Successfully fetched ${pandits.length} pandits from Firestore');
        return pandits;
      } else {
        debugPrint('No pandits found in Firestore, using fallback data');
        return _fallbackPandits;
      }
    } catch (e) {
      debugPrint('Error fetching pandits from Firestore: $e');
      debugPrint('Using fallback pandit data');
      return _fallbackPandits;
    }
  }

  // Get featured pujas
  Future<List<Map<String, dynamic>>> getFeaturedPujas() async {
    final pujas = await getAllPujas();
    return pujas.where((puja) => puja['featured'] == true).toList();
  }

  // Get featured products
  Future<List<Map<String, dynamic>>> getFeaturedProducts() async {
    final products = await getAllProducts();
    return products.where((product) => product['featured'] == true).toList();
  }

  // Get testimonials
  Future<List<Map<String, dynamic>>> getTestimonials() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _testimonials;
  }

  // Get blog posts
  Future<List<Map<String, dynamic>>> getBlogPosts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _blogs;
  }

  // Get blog post by ID
  Future<Map<String, dynamic>?> getBlogPostById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _blogs.firstWhere((blog) => blog['id'] == id, orElse: () => {});
  }

  // Get user bookings
  Future<List<Map<String, dynamic>>> getUserBookings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock user bookings
    return [
      {
        'id': 'booking1',
        'pujaId': 'puja1',
        'pujaName': 'Satyanarayan Puja',
        'bookingDate': '2023-07-15',
        'status': 'Confirmed',
        'amount': 1999.0,
      }
    ];
  }

  // Get user orders
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock user orders
    return [
      {
        'id': 'order1',
        'items': ['Brass Diya Set', 'Incense Sticks Bundle'],
        'orderDate': '2023-06-28',
        'status': 'Delivered',
        'amount': 899.0,
      }
    ];
  }
} 