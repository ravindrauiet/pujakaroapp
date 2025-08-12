import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock product data with actual image paths
    final products = [
      {
        'id': '1',
        'name': 'Brass Diya',
        'price': '₹499',
        'image': 'assets/images/prashad.svg', // Using an available image
        'rating': 4.8,
        'category': 'Puja Items',
      },
      {
        'id': '2',
        'name': 'Sandalwood Incense Sticks',
        'price': '₹199',
        'image': 'assets/images/pujaThali.jpg',
        'rating': 4.5,
        'category': 'Incense',
      },
      {
        'id': '3',
        'name': 'Silver Puja Thali',
        'price': '₹1,299',
        'image': 'assets/images/durga-ma.jpg',  // Using existing image
        'rating': 4.9,
        'category': 'Puja Items',
      },
      {
        'id': '4',
        'name': 'Rudraksha Mala',
        'price': '₹899',
        'image': 'assets/images/flower.svg', // Using an available image
        'rating': 4.7,
        'category': 'Spiritual Jewelry',
      },
      {
        'id': '5',
        'name': 'Ganga Jal',
        'price': '₹99',
        'image': 'assets/images/satyanarayan.jpg',
        'rating': 4.6,
        'category': 'Sacred Items',
      },
      {
        'id': '6',
        'name': 'Copper Kalash',
        'price': '₹799',
        'image': 'assets/images/ganeshaa.jpg',
        'rating': 4.8,
        'category': 'Puja Items',
      },
    ];

    // Categories
    final categories = [
      'All',
      'Puja Items',
      'Incense',
      'Spiritual Jewelry',
      'Sacred Items',
      'Books',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop',
          style: TextStyle(
            color: Color(0xFF8B0000),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFF5F4B32)),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          
          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = index == 0; // First category (All) is selected by default
                
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      // Handle category selection
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFFFB9548).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF8B0000),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF8B0000) : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFFFB9548) : Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Products grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // Adjusted for more height
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imagePath = product['image'] as String;
                final isSvg = imagePath.endsWith('.svg');
                
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/product-detail',
                      arguments: {'productId': product['id']},
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: isSvg
                                ? ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFFFB9548),
                                      BlendMode.srcIn,
                                    ),
                                    child: Container(
                                      color: const Color(0xFFFEEEDC),
                                      child: const Icon(
                                        Icons.spa,
                                        color: Color(0xFF8B0000),
                                        size: 50,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        
                        // Product info
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Prevent overflow
                            children: [
                              Text(
                                product['category'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['name'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5F4B32),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFB347),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${product['rating']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product['price'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF317BEA),
                                    ),
                                  ),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFB9548),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Shop is selected
        selectedItemColor: const Color(0xFF8B0000),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // Already on shop
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
} 