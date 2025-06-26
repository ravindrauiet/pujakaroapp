import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _upcomingEvents = [];
  Map<String, dynamic> _heroStats = {
    'pujasToday': '238',
    'happyDevotees': '1,500+',
    'expertPandits': '50+',
  };

  @override
  void initState() {
    super.initState();
    _fetchHomePageContent();
  }

  Future<void> _fetchHomePageContent() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Fetch hero stats
      final statsDoc = await FirebaseFirestore.instance.collection('siteContent').doc('heroStats').get();
      if (statsDoc.exists) {
        setState(() {
          _heroStats = statsDoc.data() as Map<String, dynamic>;
        });
      }

      // Fetch upcoming events
      final eventsQuery = await FirebaseFirestore.instance
          .collection('auspiciousDates')
          .orderBy('date', descending: false)
          .get();

      if (eventsQuery.docs.isNotEmpty) {
        final now = DateTime.now();
        
        // Filter for future events and sort by date
        final eventsData = eventsQuery.docs
            .map((doc) {
              final data = doc.data();
              final eventDate = data['date'] is Timestamp 
                  ? (data['date'] as Timestamp).toDate() 
                  : DateTime.parse(data['date'].toString());
              
              return {
                'id': doc.id,
                ...data,
                'date': eventDate,
              };
            })
            .where((event) => (event['date'] as DateTime).isAfter(now))
            .toList();

        eventsData.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
        
        setState(() {
          _upcomingEvents = eventsData.take(4).toList(); // Get only next 4 events
        });
      }
    } catch (e) {
      debugPrint('Error fetching home page content: $e');
      // Use sample data as fallback
      setState(() {
        _upcomingEvents = [
          {
            'id': '1',
            'name': 'Satyanarayan Puja',
            'date': DateTime.now().add(const Duration(days: 2)),
            'icon': '🪔',
            'color': 'amber',
          },
          {
            'id': '2',
            'name': 'Ganesh Chaturthi',
            'date': DateTime.now().add(const Duration(days: 5)),
            'icon': '🙏',
            'color': 'orange',
          },
        ];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM').format(date);
  }

  int _getDaysRemaining(DateTime eventDate) {
    final diffTime = eventDate.difference(DateTime.now());
    return diffTime.inDays;
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'amber':
        return Colors.amber.shade100;
      case 'orange':
        return Colors.orange.shade100;
      case 'green':
        return Colors.green.shade100;
      case 'blue':
        return Colors.blue.shade100;
      case 'purple':
        return Colors.purple.shade100;
      default:
        return Colors.amber.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF7F1),
        image: DecorationImage(
          image: const AssetImage('assets/images/heroBanner.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
            BlendMode.lighten,
          ),
        ),
      ),
      child: Column(
        children: [
          // Main content container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Experience Sacred ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                      TextSpan(
                        text: 'Traditions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7F00),
                        ),
                      ),
                      TextSpan(
                        text: ' with PujaKaro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  width: 60,
                  height: 3,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF7F00), Colors.transparent],
                    ),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                
                // Description
                const Text(
                  'Your trusted platform for authentic puja services, religious products, and spiritual guidance delivered with devotion',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F4B32),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Features grid - 2x2
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: const [
                    FeatureItem(emoji: '🙏', text: 'Expert Pandits'),
                    FeatureItem(emoji: '🌺', text: 'Fresh Flowers'),
                    FeatureItem(emoji: '✨', text: 'Sacred Rituals'),
                    FeatureItem(emoji: '🏮', text: 'Divine Prashad'),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Call to action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Text('🪔', style: TextStyle(fontSize: 16)),
                      label: const Text('Book a Puja'),
                      onPressed: () => Navigator.pushNamed(context, '/puja-booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7F00),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      icon: const Text('🛍️', style: TextStyle(fontSize: 16)),
                      label: const Text('Shop Now'),
                      onPressed: () => Navigator.pushNamed(context, '/shop'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Stats counter row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatCounter(value: '238', label: 'Pujas Today', color: Color(0xFFFF7F00)),
                _Divider(),
                StatCounter(value: '1,500+', label: 'Happy Devotees', color: Color(0xFF8B0000)),
                _Divider(),
                StatCounter(value: '50+', label: 'Expert Pandits', color: Color(0xFF317BEA)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String emoji;
  final String text;
  
  const FeatureItem({
    Key? key,
    required this.emoji,
    required this.text,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFFFE8CC),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5F4B32),
            ),
          ),
        ),
      ],
    );
  }
}

class StatCounter extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  
  const StatCounter({
    Key? key, 
    required this.value, 
    required this.label,
    required this.color,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF5F4B32),
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      color: const Color(0xFFE0E0E0),
    );
  }
} 