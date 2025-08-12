import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock blog data
    final blogs = [
      {
        'id': '1',
        'title': 'The Significance of Diwali',
        'excerpt': 'Diwali, the festival of lights, is one of the most significant festivals in Hinduism...',
        'author': 'Acharya Sharma',
        'publishedAt': '2023-10-15',
        'image': 'assets/images/placeholder.jpg',
        'category': 'Festivals',
        'readTime': '5 min read',
      },
      {
        'id': '2',
        'title': 'Understanding Vedic Astrology',
        'excerpt': 'Vedic astrology, also known as Jyotish, is the traditional Hindu system of astrology...',
        'author': 'Dr. Joshi',
        'publishedAt': '2023-09-28',
        'image': 'assets/images/placeholder.jpg',
        'category': 'Astrology',
        'readTime': '8 min read',
      },
      {
        'id': '3',
        'title': 'The Power of Mantras',
        'excerpt': 'Mantras are sacred sounds, words, or phrases that have spiritual significance...',
        'author': 'Pandit Mishra',
        'publishedAt': '2023-09-15',
        'image': 'assets/images/placeholder.jpg',
        'category': 'Spirituality',
        'readTime': '6 min read',
      },
      {
        'id': '4',
        'title': 'Importance of Puja in Daily Life',
        'excerpt': 'Puja is not just a ritual but a way to connect with the divine and purify our minds...',
        'author': 'Acharya Tiwari',
        'publishedAt': '2023-09-01',
        'image': 'assets/images/placeholder.jpg',
        'category': 'Puja',
        'readTime': '7 min read',
      },
    ];

    // Categories
    final categories = [
      'All',
      'Festivals',
      'Astrology',
      'Spirituality',
      'Puja',
      'Culture',
    ];

    return AppScaffold(
      title: 'Blog',
      currentIndex: 3,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spiritual Insights',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF8B0000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover ancient wisdom and spiritual knowledge',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
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
          
          // Blog posts list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final post = blogs[index];
                
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${post['title']} - Coming Soon')),
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
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Post image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: SizedBox(
                            width: 100,
                            height: 120,
                            child: Image.asset(
                              post['image'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey.shade400,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Post info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F0F0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    post['category'] as String,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5F4B32),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  post['excerpt'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      post['publishedAt'] as String,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 3,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade600,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      post['readTime'] as String,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}