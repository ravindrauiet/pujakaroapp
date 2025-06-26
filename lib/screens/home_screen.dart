import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/hero_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'PujaKaro',
      currentIndex: 0,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section
            const HeroSection(),
            
            // Services section
            _buildServicesSection(),
            
            // Featured pujas section
            _buildFeaturedPujasSection(),
            
            // Testimonials section
            _buildTestimonialsSection(),
            
            // Footer space (to account for bottom navigation)
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServicesSection() {
    final services = [
      {
        'icon': '🪔',
        'title': 'Puja Booking',
        'description': 'Book authentic pujas performed by verified pandits',
        'route': '/puja-booking',
        'buttonText': 'Book Now'
      },
      {
        'icon': '🌺',
        'title': 'Flowers & Mala',
        'description': 'Fresh flowers and garlands delivered to your doorstep',
        'route': '/flowers-and-mala',
        'buttonText': 'Subscribe Now'
      },
      {
        'icon': '🍎',
        'title': 'Prashad Services',
        'description': 'Sacred Prasad offerings prepared with pure devotion',
        'route': '/prashad-services',
        'buttonText': 'Subscribe Now'
      },
    ];
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Our ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                      TextSpan(
                        text: 'Services',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFB9548),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 3,
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFB9548), Color(0xFF317BEA)],
                    ),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                const Text(
                  'Experience the divine through our comprehensive spiritual services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5F4B32),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Service cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
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
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEEEDC),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          service['icon'] as String,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            service['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B0000),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service['description'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF5F4B32),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${service['title']} coming soon')),
                              );
                            },
                            child: Text(service['buttonText'] as String),
                          ),
                        ],
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
  
  Widget _buildFeaturedPujasSection() {
    // Mock data for featured pujas
    final pujas = [
      {
        'id': '1',
        'name': 'Satyanarayan Puja',
        'price': '₹1,100',
        'duration': '3 hours',
        'image': 'satyanarayan.jpg',
        'rating': 4.8,
      },
      {
        'id': '2',
        'name': 'Ganesh Puja',
        'price': '₹900',
        'duration': '2 hours',
        'image': 'ganesh.jpg',
        'rating': 4.7,
      },
      {
        'id': '3',
        'name': 'Durga Puja',
        'price': '₹1,500',
        'duration': '4 hours',
        'image': 'durga-ma.jpg',
        'rating': 4.9,
      },
    ];
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Pujas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          Container(
            width: 50,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFB9548), Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
          const Text(
            'Most popular pujas performed by our expert pandits',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5F4B32),
            ),
          ),
          const SizedBox(height: 16),
          
          // Featured pujas cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pujas.length,
            itemBuilder: (context, index) {
              final puja = pujas[index];
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${puja['name']} booking coming soon')),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                puja['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B0000),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFB347),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${puja['rating']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    puja['price'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF317BEA),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• ${puja['duration']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${puja['name']} booking coming soon')),
                                  );
                                },
                                child: const Text('Book Now'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // View all button
          Builder(
            builder: (context) => Center(
              child: TextButton.icon(
                icon: const Text('View All Pujas'),
                label: const Icon(Icons.arrow_forward),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Puja booking coming soon')),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF317BEA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTestimonialsSection() {
    final testimonials = [
      {
        'name': 'Rahul Sharma',
        'location': 'Mumbai',
        'rating': 5,
        'text': 'The puja was performed with such dedication and authenticity. The pandit explained every ritual and its significance beautifully.',
      },
      {
        'name': 'Priya Patel',
        'location': 'Delhi',
        'rating': 5,
        'text': 'Quality products and timely delivery. The flowers were fresh and the puja samagri was of excellent quality.',
      },
    ];
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF8F4EB),
      child: Column(
        children: [
          const Text(
            'What Our Customers Say',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 50,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFB9548), Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final testimonial = testimonials[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
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
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            testimonial['name'].toString()[0],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B0000),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B0000),
                              ),
                            ),
                            Text(
                              testimonial['location'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < (testimonial['rating'] as int) ? Icons.star : Icons.star_border,
                              color: const Color(0xFFFFB347),
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      testimonial['text'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5F4B32),
                        fontStyle: FontStyle.italic,
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
} 