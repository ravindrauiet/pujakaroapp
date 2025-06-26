import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../widgets/app_scaffold.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final items = cartService.items;
    
    return AppScaffold(
      title: 'Your Cart',
      body: items.isEmpty
          ? _buildEmptyCart(context)
          : _buildCart(context, items, cartService),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add products or pujas to your cart',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/shop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Shop Now'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/puja-booking'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFB9548),
            ),
            child: const Text('Book a Puja'),
          ),
        ],
      ),
    );
  }

  Widget _buildCart(
    BuildContext context,
    List<CartItem> items,
    CartService cartService,
  ) {
    final totalAmount = cartService.totalAmount;
    
    return Column(
      children: [
        // Cart items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCartItem(context, item, cartService);
            },
          ),
        ),
        
        // Order summary
        _buildOrderSummary(context, totalAmount),
      ],
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartItem item,
    CartService cartService,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/placeholder.jpg'),
                  image: AssetImage('assets/images/${item.image}'),
                  imageErrorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${item.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF317BEA),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: item.type == 'puja'
                          ? const Color(0xFFFFE0B2)
                          : const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.type == 'puja' ? 'Puja' : 'Product',
                      style: TextStyle(
                        fontSize: 12,
                        color: item.type == 'puja'
                            ? const Color(0xFFE65100)
                            : const Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quantity controls
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: item.quantity > 1
                          ? () => cartService.updateQuantity(item.id, item.quantity - 1)
                          : null,
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => cartService.updateQuantity(item.id, item.quantity + 1),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => cartService.removeItem(item.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    double totalAmount,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Tax',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '₹0.00',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF317BEA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Checkout button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/booking-form');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B0000),
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }
} 