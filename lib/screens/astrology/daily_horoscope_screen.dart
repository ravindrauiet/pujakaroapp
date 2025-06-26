import 'package:flutter/material.dart';

class DailyHoroscopeScreen extends StatefulWidget {
  const DailyHoroscopeScreen({super.key});

  @override
  State<DailyHoroscopeScreen> createState() => _DailyHoroscopeScreenState();
}

class _DailyHoroscopeScreenState extends State<DailyHoroscopeScreen> {
  final List<Map<String, dynamic>> _zodiacSigns = [
    {
      'name': 'Aries',
      'dates': 'Mar 21 - Apr 19',
      'emoji': '♈',
      'element': 'Fire',
      'ruling_planet': 'Mars',
    },
    {
      'name': 'Taurus',
      'dates': 'Apr 20 - May 20',
      'emoji': '♉',
      'element': 'Earth',
      'ruling_planet': 'Venus',
    },
    {
      'name': 'Gemini',
      'dates': 'May 21 - Jun 20',
      'emoji': '♊',
      'element': 'Air',
      'ruling_planet': 'Mercury',
    },
    {
      'name': 'Cancer',
      'dates': 'Jun 21 - Jul 22',
      'emoji': '♋',
      'element': 'Water',
      'ruling_planet': 'Moon',
    },
    {
      'name': 'Leo',
      'dates': 'Jul 23 - Aug 22',
      'emoji': '♌',
      'element': 'Fire',
      'ruling_planet': 'Sun',
    },
    {
      'name': 'Virgo',
      'dates': 'Aug 23 - Sep 22',
      'emoji': '♍',
      'element': 'Earth',
      'ruling_planet': 'Mercury',
    },
    {
      'name': 'Libra',
      'dates': 'Sep 23 - Oct 22',
      'emoji': '♎',
      'element': 'Air',
      'ruling_planet': 'Venus',
    },
    {
      'name': 'Scorpio',
      'dates': 'Oct 23 - Nov 21',
      'emoji': '♏',
      'element': 'Water',
      'ruling_planet': 'Pluto',
    },
    {
      'name': 'Sagittarius',
      'dates': 'Nov 22 - Dec 21',
      'emoji': '♐',
      'element': 'Fire',
      'ruling_planet': 'Jupiter',
    },
    {
      'name': 'Capricorn',
      'dates': 'Dec 22 - Jan 19',
      'emoji': '♑',
      'element': 'Earth',
      'ruling_planet': 'Saturn',
    },
    {
      'name': 'Aquarius',
      'dates': 'Jan 20 - Feb 18',
      'emoji': '♒',
      'element': 'Air',
      'ruling_planet': 'Uranus',
    },
    {
      'name': 'Pisces',
      'dates': 'Feb 19 - Mar 20',
      'emoji': '♓',
      'element': 'Water',
      'ruling_planet': 'Neptune',
    },
  ];

  String _selectedSign = 'Aries';
  final DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Horoscope',
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
          // Date selector
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFFF6E5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {
                    // Previous day
                  },
                ),
                Column(
                  children: [
                    const Text(
                      'Your Daily Horoscope',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5F4B32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_currentDate.day} ${_getMonthName(_currentDate.month)}, ${_currentDate.year}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    // Next day
                  },
                ),
              ],
            ),
          ),
          
          // Zodiac signs horizontal list
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _zodiacSigns.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final sign = _zodiacSigns[index];
                final isSelected = sign['name'] == _selectedSign;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSign = sign['name'] as String;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF8B0000) : Colors.white,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sign['emoji'] as String,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sign['name'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : const Color(0xFF5F4B32),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Selected sign details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildHoroscopeContent(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHoroscopeContent() {
    final selectedSignData = _zodiacSigns.firstWhere(
      (sign) => sign['name'] == _selectedSign,
      orElse: () => _zodiacSigns.first,
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sign header
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFB9548),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  selectedSignData['emoji'] as String,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedSignData['name'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
                Text(
                  selectedSignData['dates'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F4B32),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildSignAttribute('Element', selectedSignData['element'] as String),
                    const SizedBox(width: 16),
                    _buildSignAttribute('Planet', selectedSignData['ruling_planet'] as String),
                  ],
                ),
              ],
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Horoscope sections
        _buildHoroscopeSection(
          'Overview',
          'Today brings a wave of creative energy that will help you tackle problems from a fresh perspective. Your natural leadership abilities shine, making it an excellent day for group activities.',
          Icons.auto_awesome,
        ),
        
        _buildHoroscopeSection(
          'Love & Relationships',
          'If you\'re in a relationship, expect meaningful conversations that strengthen your bond. Singles might find themselves attracted to someone with strong intellectual qualities.',
          Icons.favorite,
        ),
        
        _buildHoroscopeSection(
          'Career & Money',
          'A project you\'ve been working on gains positive attention from superiors. Financial decisions made today will have long-term benefits, especially if they involve investments.',
          Icons.work,
        ),
        
        _buildHoroscopeSection(
          'Health & Wellness',
          'Your energy levels are high today, making it perfect for physical activities. Pay attention to your diet and consider incorporating more leafy greens for added vitality.',
          Icons.spa,
        ),
        
        const SizedBox(height: 16),
        
        // Lucky elements
        Container(
          padding: const EdgeInsets.all(16),
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
              const Text(
                'Lucky Elements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLuckyElement('Color', '🎨', 'Red'),
                  _buildLuckyElement('Number', '🔢', '9'),
                  _buildLuckyElement('Day', '📅', 'Tuesday'),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Compatibility
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF6E5), Color(0xFFFEEDDD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Best Compatibility',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCompatibilitySign('Leo', '♌'),
                  _buildCompatibilitySign('Sagittarius', '♐'),
                  _buildCompatibilitySign('Gemini', '♊'),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // CTA for birth chart
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF317BEA).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF317BEA).withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Want a more detailed analysis?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF317BEA),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Get your personalized birth chart analysis for deeper insights into your personality, strengths, and life path.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5F4B32),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/birth-chart');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF317BEA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Get Birth Chart Analysis'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSignAttribute(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFFB9548).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHoroscopeSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFFB9548),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF5F4B32),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLuckyElement(String label, String emoji, String value) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6E5),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5F4B32),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCompatibilitySign(String name, String symbol) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFB9548),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              symbol,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B0000),
          ),
        ),
      ],
    );
  }
  
  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}


