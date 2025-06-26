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
      quantity: map['quantity'] ?? 1,
    );
  }

  double get totalPrice => price * quantity;
} 