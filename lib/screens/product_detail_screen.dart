import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../services/cart_service.dart';
import '../widgets/app_scaffold.dart';
import '../models/cart_item.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic> _item = {};
  String _itemType = 'product'; // 'product' or 'puja'
  
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '09:00 AM';
  int _quantity = 1;

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
    
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final id = args['id'] as String;
      final type = args['type'] as String? ?? 'product';
      
      _itemType = type;
      _fetchItemDetails(id);
    }
  }

  Future<void> _fetchItemDetails(String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dataService = Provider.of<DataService>(context, listen: false);
      Map<String, dynamic>? data;
      
      if (_itemType == 'puja') {
        data = await dataService.getPujaById(id);
      } else {
        data = await dataService.getProductById(id);
      }
      
      if (data != null) {
        setState(() {
          _item = data;
          _isLoading = false;
        });
      } else {
        // Item not found
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error fetching item details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addToCart() {
    if (_item.isEmpty) return;
    
    final cartService = Provider.of<CartService>(context, listen: false);
    
    final item = CartItem(
      id: _item['id'],
      name: _item['name'] ?? 'Unknown',
      price: double.tryParse(_item['price']?.toString() ?? '0') ?? 0,
      image: _item['image'] ?? 'placeholder.jpg',
      type: _itemType,
      quantity: _quantity,
    );
    
    cartService.addItem(item);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_item['name']} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
    
    if (_itemType == 'product') {
      Navigator.pop(context);
    }
  }

  Future<void> _bookPuja() async {
    if (_item.isEmpty) return;
    
    // In a real app, this would navigate to a booking form or confirmation page
    // For now, just add it to cart
    _addToCart();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: _itemType == 'puja' ? 'Puja Details' : 'Product Details',
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  _buildImageSection(),
                  
                  // Details
                  _buildDetailsSection(),
                  
                  // Booking options for pujas
                  if (_itemType == 'puja') _buildBookingOptions(),
                  
                  // Description
                  _buildDescriptionSection(),
                  
                  // What's included (for pujas)
                  if (_itemType == 'puja') _buildWhatsIncludedSection(),
                  
                  // Reviews
                  _buildReviewsSection(),
                  
                  // Action button
                  _buildActionButton(),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/${_item['image'] ?? 'placeholder.jpg'}',
          ),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
      ),
      child: Stack(
        children: [
          // Dark overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          
          // Rating badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFFB347),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_item['rating'] ?? 4.5}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${_item['reviews'] ?? 0} reviews)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            _item['name'] ?? 'Item Name',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 8),
          
          // Price and duration row
          Row(
            children: [
              Text(
                '₹${_item['price'] ?? 0}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF317BEA),
                ),
              ),
              
              const SizedBox(width: 16),
              
              if (_itemType == 'puja')
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Duration: ${_item['duration'] ?? 2} hours',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._buildTagChips(),
              
              // Format for pujas
              if (_itemType == 'puja')
                Chip(
                  label: Text(_item['format'] ?? 'In-person'),
                  backgroundColor: const Color(0xFFE3F2FD),
                ),
              
              // Language for pujas
              if (_itemType == 'puja' && _item['language'] != null)
                Chip(
                  label: Text('Language: ${_item['language']}'),
                  backgroundColor: const Color(0xFFE8F5E9),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTagChips() {
    final tags = _item['tags'] as List? ?? [];
    return tags
        .map((tag) => Chip(
              label: Text(tag.toString()),
              backgroundColor: const Color(0xFFFFF3E0),
            ))
        .toList();
  }

  Widget _buildBookingOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Date & Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B0000),
                ),
              ),
              const SizedBox(height: 16),
              
              // Date picker
              InkWell(
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 12),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Time picker
              DropdownButtonFormField<String>(
                value: _selectedTime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.access_time),
                ),
                items: _availableTimes
                    .map((time) => DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedTime = value;
                    });
                  }
                },
              ),
              
              // Quantity selector for products
              if (_itemType == 'product') ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _quantity > 1
                          ? () {
                              setState(() {
                                _quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _item['description'] ??
                'No description available for this ${_itemType == 'puja' ? 'puja' : 'product'}.',
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

  Widget _buildWhatsIncludedSection() {
    final items = _item['included'] as List? ?? [];
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s Included',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF317BEA),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5F4B32),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          if (items.isEmpty)
            const Text(
              'No items specified.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                  color: Color(0xFF8B0000),
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all reviews
                },
                child: Text(
                  'View All (${_item['reviews'] ?? 0})',
                  style: const TextStyle(
                    color: Color(0xFF317BEA),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Sample review
          Card(
            elevation: 0,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF8B0000),
                        radius: 16,
                        child: Text(
                          'R',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Rahul Sharma',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 14,
                            color: index < 5
                                ? const Color(0xFFFFB347)
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The puja was performed beautifully and all rituals were explained properly. Would highly recommend!',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _itemType == 'puja' ? _bookPuja : _addToCart,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B0000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            _itemType == 'puja' ? 'Book This Puja' : 'Add to Cart',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
} 