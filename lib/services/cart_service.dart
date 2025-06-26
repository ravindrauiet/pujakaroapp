import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

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