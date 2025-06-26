import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PujaKaro',
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner Section
            _buildHeroSection(context),
            
            // Services Section
            _buildServicesSection(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
            // Already on home
          } else if (index == 1) {
            Navigator.pushNamed(context, '/shop');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
  
  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 500,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/heroBanner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Gradient Overlay
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFFFFF6E5).withOpacity(0.6),
                const Color(0xFFFFF6E5).withOpacity(0.4),
              ],
            ),
          ),
        ),
        
        // Bottom Gradient
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFF6E5).withOpacity(0),
                  const Color(0xFFFFF6E5).withOpacity(0.4),
                ],
              ),
            ),
          ),
        ),
        
        // Floating Symbols
        Positioned(
          top: 100,
          right: 60,
          child: Text(
            '🕉️',
            style: TextStyle(
              fontSize: 32,
              color: const Color(0xFFFF7F00).withOpacity(0.4),
            ),
          ),
        ),
        
        Positioned(
          bottom: 120,
          right: 120,
          child: Text(
            '🪔',
            style: TextStyle(
              fontSize: 32,
              color: const Color(0xFFFF7F00).withOpacity(0.4),
            ),
          ),
        ),
        
        Positioned(
          top: 200,
          right: 100,
          child: Text(
            '🙏',
            style: TextStyle(
              fontSize: 32,
              color: const Color(0xFFFF7F00).withOpacity(0.4),
            ),
          ),
        ),
        
        // Main Content
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Content Container with Saffron Border
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFF7F00).withOpacity(0.6),
                      width: 2,
                    ),
                    color: const Color(0xFFFFF8ED),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline with Highlighted Text
                      const Text(
                        'Experience Sacred Traditions with PujaKaro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                          height: 1.2,
                        ),
                      ),
                      
                      // Divider
                      Container(
                        width: 80,
                        height: 3,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF7F00), Colors.transparent],
                          ),
                        ),
                      ),
                      
                      // Description with Icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '🪔',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFFFF7F00),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your trusted platform for authentic puja services, religious products, and spiritual guidance delivered with devotion',
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color(0xFF5F4B32),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Featured Services Summary
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFeatureItem('🙏', 'Expert Pandits'),
                          _buildFeatureItem('🌺', 'Fresh Flowers'),
                          _buildFeatureItem('✨', 'Sacred Rituals'),
                          _buildFeatureItem('🏮', 'Divine Prashad'),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Call to Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Book a Puja Button
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/puja-booking');
                            },
                            icon: const Text('🪔', style: TextStyle(fontSize: 20)),
                            label: const Row(
                              children: [
                                Text('Book a Puja'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7F00),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Shop Now Button
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/shop');
                            },
                            icon: const Text('🛍️', style: TextStyle(fontSize: 20)),
                            label: const Row(
                              children: [
                                Text('Shop Now'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B0000),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        ),
      ],
    );
  }
  
  Widget _buildFeatureItem(String emoji, String text) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE8CC),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5F4B32),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildServicesSection(BuildContext context) {
    final services = [
      {
        'icon': '🪔',
        'title': 'Puja Booking',
        'description': 'Book authentic pujas performed by verified pandits',
        'buttonText': 'Book Now',
        'route': '/puja-booking',
      },
      {
        'icon': '🌺',
        'title': 'Flowers & Mala',
        'description': 'Fresh flowers and garlands delivered to your doorstep',
        'buttonText': 'Subscribe Now',
        'route': '/flowers-and-mala',
      },
      {
        'icon': '🍎',
        'title': 'Prashad Services',
        'description': 'Sacred Prasad offerings prepared with pure devotion',
        'buttonText': 'Subscribe Now',
        'route': '/prashad-services',
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        children: [
          // Section Title
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Our ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
                TextSpan(
                  text: 'Services',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFB9548),
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Container(
            width: 100,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFB9548), Color(0xFF317BEA)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const Text(
            'Experience the divine through our comprehensive spiritual services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5F4B32),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Service Cards
          ...services.map((service) => _buildServiceCard(
            context,
            icon: service['icon'] as String,
            title: service['title'] as String,
            description: service['description'] as String,
            buttonText: service['buttonText'] as String,
            route: service['route'] as String,
          )).toList(),
        ],
      ),
    );
  }
  
  Widget _buildServiceCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    required String buttonText,
    required String route,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFFEEEDC),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF5F4B32),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, route);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF317BEA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 