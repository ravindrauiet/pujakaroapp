import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String type;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.type,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'type': type,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      price: (map['price'] is int) ? (map['price'] as int).toDouble() : map['price'],
      image: map['image'],
      type: map['type'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    String? type,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartService with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;

  // Getters
  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  
  int get itemCount {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  double get totalAmount {
    return _items.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  CartService() {
    _loadCartFromPrefs();
  }

  // Load cart from SharedPreferences
  Future<void> _loadCartFromPrefs() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');
      
      if (cartData != null) {
        final List<dynamic> decoded = json.decode(cartData);
        _items = decoded.map((item) => CartItem.fromMap(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Save cart to SharedPreferences
  Future<void> _saveCartToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = json.encode(_items.map((item) => item.toMap()).toList());
      await prefs.setString('cart', cartData);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  // Add item to cart
  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);
    
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += 1;
    } else {
      _items.add(item);
    }
    
    notifyListeners();
    _saveCartToPrefs();
  }

  // Remove item from cart
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
    _saveCartToPrefs();
  }

  // Update item quantity
  void updateQuantity(String itemId, int quantity) {
    if (quantity < 1) {
      removeItem(itemId);
      return;
    }
    
    final itemIndex = _items.indexWhere((item) => item.id == itemId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
      notifyListeners();
      _saveCartToPrefs();
    }
  }

  // Clear cart
  void clearCart() {
    _items = [];
    notifyListeners();
    _saveCartToPrefs();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
} 