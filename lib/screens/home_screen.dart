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
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF5F4B32)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFF5F4B32)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart coming soon')),
              );
            },
          ),
        ],
        elevation: 2,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Promotional Banner
            _buildPromotionalBanner(),
            
            // Hero Banner Section
            _buildHeroSection(context),
            
            // Services Section
            _buildServicesSection(context),
            
            // Statistics Section
            _buildStatisticsSection(),
            
            // Upcoming Auspicious Dates
            _buildUpcomingDatesSection(context),
            
            // Why Choose Us Section
            _buildWhyChooseUsSection(),
            
            // Featured Puja Section
            _buildFeaturedPujaSection(context),
            
            // Testimonial Section
            _buildTestimonialSection(),
            
            // Pandit Section
            _buildPanditSection(context),
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
  
  Widget _buildPromotionalBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: const Color(0xFF8B0000),
      child: Row(
        children: [
          const Text(
            '🪔',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Offer!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '20% off on all puja bookings this week',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                color: Color(0xFF8B0000),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B0000), Color(0xFFFB9548)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.spa,
                      size: 50,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'PujaKaro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Your Spiritual Journey Begins Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.event,
            title: 'Puja Booking',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/puja-booking');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_bag,
            title: 'Shop',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/shop');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.local_florist,
            title: 'Flowers & Mala',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/flowers-and-mala');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.food_bank,
            title: 'Prashad Services',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/prashad-services');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.stars,
            title: 'Astrology',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/daily-horoscope');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.article,
            title: 'Blog',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/blog');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about-us');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.contact_support,
            title: 'Contact Us',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/privacy-policy');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.policy,
            title: 'Terms & Conditions',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/terms');
            },
          ),
          const Divider(),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.logout, color: Color(0xFF8B0000)),
                SizedBox(width: 12),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFF8B0000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Implement logout functionality
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF5F4B32)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF5F4B32),
          fontSize: 16,
        ),
      ),
      onTap: onTap,
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
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
        ),
        
        // Main Content
        Positioned(
          top: 250,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Content Container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline with Highlighted Text
                      const Text(
                        'Connect with Divine through PujaKaro',
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
                            colors: [Color(0xFFFF7F00), Color(0xFFFFF6E5)],
                          ),
                        ),
                      ),
                      
                      // Description
                      const Text(
                        'Your trusted platform for authentic puja services, religious products, and spiritual guidance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5F4B32),
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Call to Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Book a Puja Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/puja-booking');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF7F00),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Book a Puja',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Shop Now Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/shop');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF317BEA),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
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
  
  Widget _buildStatisticsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Our Achievements',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('238', 'Pujas Today', const Color(0xFFAF601A)),
              _buildStatCard('1,500+', 'Happy Devotees', const Color(0xFFFF7F00)),
              _buildStatCard('50+', 'Expert Pandits', const Color(0xFF8B0000)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String number, String label, Color color) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF5F4B32),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  Widget _buildUpcomingDatesSection(BuildContext context) {
    // Sample upcoming dates data
    final upcomingDates = [
      {
        'name': 'Satyanarayan Puja',
        'date': DateTime.now().add(const Duration(days: 2)),
        'icon': '🪔',
        'color': Colors.amber.shade50,
        'textColor': Colors.amber.shade800,
        'borderColor': Colors.amber.shade200,
      },
      {
        'name': 'Ganesh Chaturthi',
        'date': DateTime.now().add(const Duration(days: 5)),
        'icon': '🙏',
        'color': Colors.orange.shade50,
        'textColor': Colors.orange.shade800,
        'borderColor': Colors.orange.shade200,
      },
      {
        'name': 'Sundarkand Path',
        'date': DateTime.now().add(const Duration(days: 9)),
        'icon': '✨',
        'color': Colors.yellow.shade50,
        'textColor': Colors.yellow.shade800,
        'borderColor': Colors.yellow.shade200,
      },
      {
        'name': 'Laxmi Puja',
        'date': DateTime.now().add(const Duration(days: 12)),
        'icon': '💫',
        'color': Colors.pink.shade50,
        'textColor': Colors.pink.shade800,
        'borderColor': Colors.pink.shade200,
      },
    ];
    
    // Format date for display
    String formatDate(DateTime date) {
      final List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]}';
    }
    
    // Calculate days remaining
    int getDaysRemaining(DateTime date) {
      return date.difference(DateTime.now()).inDays;
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B0000), Color(0xFFFF7F00)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('✨', style: TextStyle(fontSize: 18)),
                SizedBox(width: 8),
                Text(
                  'Upcoming Auspicious Dates',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...upcomingDates.map((event) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/puja-booking');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: event['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: event['borderColor'] as Color),
                    ),
                    child: Row(
                      children: [
                        Text(
                          event['icon'] as String,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['name'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: event['textColor'] as Color,
                                ),
                              ),
                              Text(
                                formatDate(event['date'] as DateTime),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: (event['textColor'] as Color).withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${getDaysRemaining(event['date'] as DateTime)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: event['textColor'] as Color,
                              ),
                            ),
                            Text(
                              'days left',
                              style: TextStyle(
                                fontSize: 12,
                                color: (event['textColor'] as Color).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )).toList(),
                
                const SizedBox(height: 16),
                
                // Daily Horoscope Link
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/daily-horoscope');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B0000).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Daily Horoscope',
                          style: TextStyle(
                            color: Color(0xFF8B0000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Color(0xFF8B0000),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWhyChooseUsSection() {
    final benefits = [
      {
        'icon': '🙏',
        'title': 'Authentic Puja Services',
        'description': 'Traditional rituals performed by experienced pandits following all sacred traditions',
      },
      {
        'icon': '🕐',
        'title': 'On-time Delivery',
        'description': 'We respect your time and ensure all services are delivered at the scheduled time',
      },
      {
        'icon': '💯',
        'title': 'Satisfaction Guaranteed',
        'description': 'Experience peace of mind with our 100% satisfaction guarantee policy',
      },
      {
        'icon': '💸',
        'title': 'Transparent Pricing',
        'description': 'No hidden charges. What you see is what you pay, with detailed pricing for all services',
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Why ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
                TextSpan(
                  text: 'Choose Us',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFB9548),
                  ),
                ),
              ],
            ),
          ),
          
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
            'Experience the divine with confidence through our trusted services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5F4B32),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Benefits Grid
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: benefits.length,
            itemBuilder: (context, index) {
              final benefit = benefits[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEEEDC),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          benefit['icon'] as String,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      benefit['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      benefit['description'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeaturedPujaSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Featured ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
                TextSpan(
                  text: 'Pujas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFB9548),
                  ),
                ),
              ],
            ),
          ),
          
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
            'Popular puja ceremonies performed by our experienced pandits',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5F4B32),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Featured Puja Card
          _buildFeaturedPujaCard(
            context: context,
            title: 'Satyanarayan Puja',
            description: 'Appease Lord Vishnu and seek his blessings with this sacred ceremony',
            image: 'assets/images/satyanarayan.jpg',
            price: '₹1,999',
            duration: '2 hours',
            rating: 4.9,
          ),
          
          const SizedBox(height: 20),
          
          // See All Button
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/puja-booking');
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All Pujas',
                  style: TextStyle(
                    color: Color(0xFF8B0000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Color(0xFF8B0000),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeaturedPujaCard({
    required BuildContext context,
    required String title,
    required String description,
    required String image,
    required String price,
    required String duration,
    required double rating,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB9548),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Featured',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      ' (128 reviews)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF317BEA),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/puja-booking');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB9548),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTestimonialSection() {
    final testimonials = [
      {
        'name': 'Ankita Sharma',
        'location': 'Mumbai',
        'image': 'assets/images/flower.svg', // Placeholder - replace with actual avatar
        'comment': 'The Satyanarayan Puja was performed with such devotion. The pandit was very knowledgeable and guided us through the entire process.',
        'rating': 5,
      },
      {
        'name': 'Rajesh Kumar',
        'location': 'Delhi',
        'image': 'assets/images/flower.svg', // Placeholder - replace with actual avatar
        'comment': 'Excellent service! The pandit was punctual and the materials provided were of high quality. Will definitely recommend to friends and family.',
        'rating': 5,
      },
      {
        'name': 'Priya Patel',
        'location': 'Ahmedabad',
        'image': 'assets/images/flower.svg', // Placeholder - replace with actual avatar
        'comment': 'We had a beautiful Griha Pravesh ceremony. The arrangements were perfect and the pandit was very professional and friendly.',
        'rating': 4,
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Happy ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                  TextSpan(
                    text: 'Devotees',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB9548),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
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
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'See what our devotees are saying about their spiritual journey with us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF5F4B32),
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Testimonial Cards
          SizedBox(
            height: 220,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFFFEEEDC),
                            child: Text(
                              testimonial['name'].toString()[0],
                              style: const TextStyle(
                                color: Color(0xFF8B0000),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testimonial['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                testimonial['location'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        testimonial['comment'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < (testimonial['rating'] as int)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPanditSection(BuildContext context) {
    final pandits = [
      {
        'name': 'Pandit Ramesh Sharma',
        'image': 'assets/images/rameshJi.jpg',
        'expertise': 'Vedic Rituals',
        'experience': '15+ years',
        'language': 'Hindi, English',
        'rating': 4.9,
      },
      {
        'name': 'Pandit Suresh Joshi',
        'image': 'assets/images/ganesh.jpg',  // Replace with actual pandit image
        'expertise': 'Ganesh Puja',
        'experience': '12+ years',
        'language': 'Hindi, Marathi',
        'rating': 4.8,
      },
      {
        'name': 'Acharya Mukesh Tiwari',
        'image': 'assets/images/shivji.jpg',  // Replace with actual pandit image
        'expertise': 'Vastu & Jyotish',
        'experience': '20+ years',
        'language': 'Hindi, English, Sanskrit',
        'rating': 5.0,
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        children: [
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
                  text: 'Pandits',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFB9548),
                  ),
                ),
              ],
            ),
          ),
          
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
            'Experienced and knowledgeable pandits to perform your sacred ceremonies',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5F4B32),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Pandit Cards
          SizedBox(
            height: 320, // Increased height to avoid overflow
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pandits.length,
              itemBuilder: (context, index) {
                final pandit = pandits[index];
                return Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Pandit Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          pandit['image'] as String,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Pandit Info
                      Expanded( // Use Expanded to avoid overflow
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min, // Use min size
                            children: [
                              Text(
                                pandit['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B0000),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min, // Use min size
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${pandit['rating']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildPanditInfoRow(
                                Icons.badge,
                                'Expertise: ${pandit['expertise']}',
                              ),
                              _buildPanditInfoRow(
                                Icons.work,
                                'Exp: ${pandit['experience']}',
                              ),
                              _buildPanditInfoRow(
                                Icons.language,
                                '${pandit['language']}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // View All Button
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/puja-booking');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF8B0000),
              side: const BorderSide(color: Color(0xFF8B0000)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('View All Pandits'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPanditInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Use min size to avoid overflow
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Flexible( // Use Flexible to allow text wrapping
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
} 