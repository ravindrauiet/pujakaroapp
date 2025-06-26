import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock blog data
    final blogPosts = [
      {
        'id': '1',
        'title': 'The Significance of Satyanarayan Puja',
        'excerpt': 'Learn about the importance and benefits of performing Satyanarayan Puja...',
        'image': 'assets/images/placeholder.jpg',
        'author': 'Pandit Sharma',
        'date': 'June 15, 2023',
        'readTime': '5 min read',
        'category': 'Pujas',
      },
      {
        'id': '2',
        'title': 'Understanding the Navgraha and Their Influence',
        'excerpt': 'Discover how the nine celestial bodies affect your life and ways to appease them...',
        'image': 'assets/images/placeholder.jpg',
        'author': 'Dr. Jyoti Mishra',
        'date': 'May 28, 2023',
        'readTime': '8 min read',
        'category': 'Astrology',
      },
      {
        'id': '3',
        'title': 'The Spiritual Benefits of Daily Meditation',
        'excerpt': 'Explore how incorporating meditation into your daily routine can enhance spiritual growth...',
        'image': 'assets/images/placeholder.jpg',
        'author': 'Swami Anand',
        'date': 'April 10, 2023',
        'readTime': '6 min read',
        'category': 'Spirituality',
      },
      {
        'id': '4',
        'title': 'Sacred Plants in Hindu Tradition',
        'excerpt': 'Learn about the spiritual significance of Tulsi, Peepal, and other sacred plants...',
        'image': 'assets/images/placeholder.jpg',
        'author': 'Dr. Radha Krishnan',
        'date': 'March 22, 2023',
        'readTime': '7 min read',
        'category': 'Culture',
      },
    ];

    // Categories
    final categories = [
      'All',
      'Pujas',
      'Astrology',
      'Spirituality',
      'Culture',
      'Festivals',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog',
          style: TextStyle(
            color: Color(0xFF8B0000),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Featured blog post
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: const AssetImage('assets/images/placeholder.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB9548),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Jyestha Purnima: Significance and Rituals',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'By Pandit Ramesh',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'June 20, 2023',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
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
          
          // Blog posts list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: blogPosts.length,
              itemBuilder: (context, index) {
                final post = blogPosts[index];
                
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/blog-post',
                      arguments: {'postId': post['id']},
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
                            child: Container(
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
                                      post['date'] as String,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Blog is selected
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
            icon: Icon(Icons.celebration),
            label: 'Puja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/shop');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/puja-booking');
          } else if (index == 3) {
            // Already on blog
          }
        },
      ),
    );
  }
}