import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/data_service.dart';
import '../services/cart_service.dart';
import '../widgets/app_scaffold.dart';
import '../models/cart_item.dart';

class PujaDetailScreen extends StatefulWidget {
  const PujaDetailScreen({super.key});

  @override
  State<PujaDetailScreen> createState() => _PujaDetailScreenState();
}

class _PujaDetailScreenState extends State<PujaDetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic> _puja = {};
  
  // Booking options
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '09:00 AM';
  String _selectedPanditId = '';
  List<Map<String, dynamic>> _availablePandits = [];
  
  final List<String> _availableTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.containsKey('id')) {
      final id = args['id'] as String;
      _fetchPujaDetails(id);
      _fetchAvailablePandits();
    }
  }

  Future<void> _fetchPujaDetails(String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dataService = Provider.of<DataService>(context, listen: false);
      final puja = await dataService.getPujaById(id);
      
      if (puja != null && puja.isNotEmpty) {
        setState(() {
          _puja = puja;
          _isLoading = false;
        });
      } else {
        // Puja not found, navigate back
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error fetching puja details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future<void> _fetchAvailablePandits() async {
    try {
      final dataService = Provider.of<DataService>(context, listen: false);
      final pandits = await dataService.getAllPandits();
      
      setState(() {
        _availablePandits = pandits;
        if (pandits.isNotEmpty) {
          _selectedPanditId = pandits[0]['id'] as String;
        }
      });
    } catch (e) {
      debugPrint('Error fetching pandits: $e');
    }
  }

  void _addToCart() {
    if (_puja.isEmpty) return;
    
    final cartService = Provider.of<CartService>(context, listen: false);
    
    final formattedDate = "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
    final pujaWithBookingDetails = {
      ..._puja,
      'bookingDate': formattedDate,
      'bookingTime': _selectedTime,
      'panditId': _selectedPanditId,
    };
    
    final item = CartItem(
      id: _puja['id'],
      name: _puja['name'] ?? 'Unknown',
      price: double.tryParse(_puja['price']?.toString() ?? '0') ?? 0,
      image: _puja['image'] ?? 'placeholder.jpg',
      type: 'puja',
      quantity: 1,
    );
    
    cartService.addItem(item);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_puja['name']} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }

  void _bookPuja() {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    if (!authService.isAuthenticated) {
      // Redirect to login if not authenticated
      Navigator.pushNamed(context, '/login', arguments: {
        'redirectTo': '/puja-detail',
        'pujaId': _puja['id'],
      });
      return;
    }
    
    _addToCart();
    
    // Navigate to booking form
    Navigator.pushNamed(context, '/booking-form', arguments: {
      'puja': _puja,
      'date': _selectedDate,
      'time': _selectedTime,
      'panditId': _selectedPanditId,
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Puja Details',
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image
                  _buildPujaImage(),
                  
                  // Title and price
                  _buildHeader(),
                  
                  // Date and time selection
                  _buildDateTimePicker(),
                  
                  // Pandit selection
                  _buildPanditSelection(),
                  
                  // Description
                  _buildDescription(),
                  
                  // What's included
                  _buildWhatsIncluded(),
                  
                  // Reviews
                  _buildReviews(),
                  
                  // Book now button
                  _buildBookingButton(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
  
  Widget _buildPujaImage() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/${_puja['image'] ?? 'placeholder.jpg'}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _puja['name'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_puja['price'] ?? '0'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_puja['rating'] ?? '4.5'} (${_puja['reviews'] ?? '0'})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                'Duration: ${_puja['duration'] ?? '1 hour'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildDateTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Date and Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  value: _selectedTime,
                  items: _availableTimes.map((time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedTime = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
  
  Widget _buildPanditSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Pandit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _availablePandits.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: _availablePandits.map((pandit) {
                    final isSelected = _selectedPanditId == pandit['id'];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPanditId = pandit['id'] as String;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? const Color(0xFF8B0000) : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/${pandit['image'] ?? 'placeholder.jpg'}'),
                              radius: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pandit['name'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pandit['specialization'] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${pandit['rating']} (${pandit['reviews']} reviews)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Radio<String>(
                              value: pandit['id'] as String,
                              groupValue: _selectedPanditId,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedPanditId = value;
                                  });
                                }
                              },
                              activeColor: const Color(0xFF8B0000),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
  
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _puja['description'] ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildWhatsIncluded() {
    final List<String> includedItems = [
      'Complete puja samagri',
      'Experienced pandit',
      'Prasad for family members',
      'Sacred mantras chanting',
      'Post-puja guidance'
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s Included',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...includedItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF8B0000), size: 20),
                const SizedBox(width: 12),
                Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    // Mock reviews for demonstration
    final reviews = [
      {
        'name': 'Rajesh Kumar',
        'rating': 5,
        'comment': 'Excellent service. The pandit was very knowledgeable and guided us through the entire process.',
        'date': '15 May 2023',
      },
      {
        'name': 'Priya Singh',
        'rating': 4,
        'comment': 'Great experience. Will definitely book again.',
        'date': '10 April 2023',
      },
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...reviews.map((review) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      review['date'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (review['rating'] as int) ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  review['comment'] as String,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _bookPuja,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF8B0000),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
} 