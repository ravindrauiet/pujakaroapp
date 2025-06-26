import 'package:flutter/material.dart';

class BirthChartScreen extends StatefulWidget {
  const BirthChartScreen({super.key});

  @override
  State<BirthChartScreen> createState() => _BirthChartScreenState();
}

class _BirthChartScreenState extends State<BirthChartScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _birthTimeController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;
  bool _showResults = false;
  
  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _birthTimeController.dispose();
    _birthPlaceController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(now.year - 25, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B0000),
              onPrimary: Colors.white,
              onSurface: Color(0xFF5F4B32),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }
  
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B0000),
              onPrimary: Colors.white,
              onSurface: Color(0xFF5F4B32),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _birthTimeController.text = picked.format(context);
      });
    }
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _showResults = true;
        });
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Birth Chart Analysis',
          style: TextStyle(
            color: Color(0xFF8B0000),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _showResults ? _buildResults() : _buildForm(),
    );
  }
  
  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6E5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFB9548).withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFB9548),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '🔮',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Discover Your Cosmic Blueprint',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your birth chart is a unique cosmic snapshot of the sky at the moment you were born. It reveals your personality traits, strengths, challenges, and life path.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F4B32),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Form
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Your Birth Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5F4B32),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person, color: Color(0xFF8B0000)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8B0000)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Date of Birth
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF8B0000)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8B0000)),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Birth Time
                TextFormField(
                  controller: _birthTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Birth Time (if known)',
                    prefixIcon: const Icon(Icons.access_time, color: Color(0xFF8B0000)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8B0000)),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.schedule),
                      onPressed: () => _selectTime(context),
                    ),
                    helperText: 'More accurate results with birth time',
                  ),
                  onTap: () => _selectTime(context),
                ),
                
                const SizedBox(height: 16),
                
                // Birth Place
                TextFormField(
                  controller: _birthPlaceController,
                  decoration: InputDecoration(
                    labelText: 'Birth Place',
                    prefixIcon: const Icon(Icons.location_on, color: Color(0xFF8B0000)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8B0000)),
                    ),
                    helperText: 'City, State, Country',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your birth place';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF317BEA),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: const Color(0xFF317BEA).withOpacity(0.5),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Generate Birth Chart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Privacy note
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.privacy_tip_outlined,
                        color: Color(0xFF8B0000),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your information is private and will only be used to generate your birth chart.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResults() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info card
          Container(
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
                      backgroundColor: const Color(0xFFFFF6E5),
                      radius: 32,
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text[0].toUpperCase()
                            : 'A',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nameController.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5F4B32),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Born: ${_dobController.text}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Location: ${_birthPlaceController.text}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Birth chart image placeholder
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_graph,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Birth Chart Visualization',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5F4B32),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Planetary positions at your birth time',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Sun sign
          _buildPlanetaryPosition(
            'Sun in Leo',
            'Your sun sign represents your core identity and ego. With Sun in Leo, you are naturally confident, creative, and have a flair for the dramatic. You have strong leadership qualities and enjoy being in the spotlight.',
            '☉ ♌',
            const Color(0xFFFFB347),
          ),
          
          // Moon sign
          _buildPlanetaryPosition(
            'Moon in Cancer',
            'Your moon sign represents your emotional nature and instincts. With Moon in Cancer, you are deeply sensitive, nurturing, and have strong intuition. You value emotional security and have a strong connection to your home and family.',
            '☽ ♋',
            const Color(0xFFB5D8EB),
          ),
          
          // Rising sign
          _buildPlanetaryPosition(
            'Ascendant in Virgo',
            'Your rising sign represents how others perceive you and your approach to the world. With Virgo rising, you appear analytical, detail-oriented, and practical. You have a methodical approach to life and value organization and efficiency.',
            'Asc ♍',
            const Color(0xFF9BBA5A),
          ),
          
          // Mercury
          _buildPlanetaryPosition(
            'Mercury in Virgo',
            'Mercury represents your communication style and thinking process. With Mercury in Virgo, you have a precise, analytical mind with excellent attention to detail. You communicate clearly and logically, and have a talent for critical analysis.',
            '☿ ♍',
            const Color(0xFFB5C7A5),
          ),
          
          // Venus
          _buildPlanetaryPosition(
            'Venus in Libra',
            'Venus represents your approach to love, beauty, and values. With Venus in Libra, you are naturally diplomatic, charming, and have a strong sense of fairness. You seek harmony in relationships and have refined aesthetic tastes.',
            '♀ ♎',
            const Color(0xFFFFB6C1),
          ),
          
          const SizedBox(height: 24),
          
          // Consultation CTA
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B0000), Color(0xFFAA2222)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Want a Personalized Reading?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Book a consultation with our expert astrologers for in-depth insights and guidance tailored to your unique birth chart.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Book consultation
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF8B0000),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Book Consultation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Back button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _showResults = false;
                });
              },
              child: const Text(
                'Generate Another Chart',
                style: TextStyle(
                  color: Color(0xFF317BEA),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlanetaryPosition(String title, String description, String symbol, Color color) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      symbol.split(' ')[0],
                      style: TextStyle(
                        fontSize: 20,
                        color: color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.8),
                  ),
                ),
                const Spacer(),
                Text(
                  symbol.split(' ')[1],
                  style: TextStyle(
                    fontSize: 20,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          
          // Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF5F4B32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


