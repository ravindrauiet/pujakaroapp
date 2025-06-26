import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../widgets/app_scaffold.dart';

class PujaBookingScreen extends StatefulWidget {
  const PujaBookingScreen({super.key});

  @override
  State<PujaBookingScreen> createState() => _PujaBookingScreenState();
}

class _PujaBookingScreenState extends State<PujaBookingScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _pujas = [];
  List<Map<String, dynamic>> _filteredPujas = [];
  String _searchQuery = '';
  String _priceRange = 'all';
  String _duration = 'all';
  String _occasion = 'all';
  String _sortBy = 'popularity';
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _fetchPujas();
  }

  Future<void> _fetchPujas() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final dataService = Provider.of<DataService>(context, listen: false);
      final pujas = await dataService.getAllPujas();
      
      setState(() {
        _pujas = pujas;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching pujas: $e');
      setState(() {
        _pujas = [];
        _filteredPujas = [];
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(_pujas);
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((puja) {
        final name = puja['name']?.toString().toLowerCase() ?? '';
        final description = puja['description']?.toString().toLowerCase() ?? '';
        return name.contains(_searchQuery.toLowerCase()) ||
            description.contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Apply price range filter
    if (_priceRange != 'all') {
      final range = _priceRange.split('-');
      final min = int.parse(range[0]);
      final max = range.length > 1 ? int.parse(range[1]) : null;
      
      filtered = filtered.where((puja) {
        final price = double.tryParse(puja['price']?.toString() ?? '0') ?? 0;
        if (max == null) {
          return price >= min;
        } else {
          return price >= min && price <= max;
        }
      }).toList();
    }
    
    // Apply duration filter
    if (_duration != 'all') {
      filtered = filtered.where((puja) {
        final hours = double.tryParse(puja['duration']?.toString() ?? '0') ?? 0;
        switch (_duration) {
          case 'short':
            return hours <= 2;
          case 'medium':
            return hours > 2 && hours <= 3;
          case 'long':
            return hours > 3;
          default:
            return true;
        }
      }).toList();
    }
    
    // Apply occasion filter
    if (_occasion != 'all') {
      filtered = filtered.where((puja) {
        final occasions = puja['occasions'] as List?;
        return occasions?.contains(_occasion) ?? false;
      }).toList();
    }
    
    // Apply sorting
    switch (_sortBy) {
      case 'price-low-high':
        filtered.sort((a, b) {
          final priceA = double.tryParse(a['price']?.toString() ?? '0') ?? 0;
          final priceB = double.tryParse(b['price']?.toString() ?? '0') ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'price-high-low':
        filtered.sort((a, b) {
          final priceA = double.tryParse(a['price']?.toString() ?? '0') ?? 0;
          final priceB = double.tryParse(b['price']?.toString() ?? '0') ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'rating':
        filtered.sort((a, b) {
          final ratingA = double.tryParse(a['rating']?.toString() ?? '0') ?? 0;
          final ratingB = double.tryParse(b['rating']?.toString() ?? '0') ?? 0;
          return ratingB.compareTo(ratingA);
        });
        break;
      case 'popularity':
      default:
        filtered.sort((a, b) {
          final reviewsA = int.tryParse(a['reviews']?.toString() ?? '0') ?? 0;
          final reviewsB = int.tryParse(b['reviews']?.toString() ?? '0') ?? 0;
          return reviewsB.compareTo(reviewsA);
        });
    }
    
    setState(() {
      _filteredPujas = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Book a Puja',
      currentIndex: 2,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchPujas,
              child: Column(
                children: [
                  // Search and Filter Bar
                  _buildSearchFilterBar(),
                  
                  // Filter options (expandable)
                  if (_showFilters) _buildFilterOptions(),
                  
                  // Puja List
                  Expanded(
                    child: _filteredPujas.isEmpty
                        ? _buildEmptyState()
                        : _buildPujaList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Search field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for pujas...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _applyFilters();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              // Date picker
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  // Handle date selection...
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 4),
                      Text('Date'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Filter toggle button
              InkWell(
                onTap: () {
                  setState(() {
                    _showFilters = !_showFilters;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 16),
                      const SizedBox(width: 4),
                      Text(_showFilters ? 'Hide Filters' : 'Filters'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter By:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          // Price Range Filter
          Row(
            children: [
              const Text('Price: '),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _priceRange,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Prices')),
                    DropdownMenuItem(value: '0-1000', child: Text('Under ₹1000')),
                    DropdownMenuItem(value: '1000-2000', child: Text('₹1000 - ₹2000')),
                    DropdownMenuItem(value: '2000-5000', child: Text('₹2000 - ₹5000')),
                    DropdownMenuItem(value: '5000', child: Text('Above ₹5000')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _priceRange = value ?? 'all';
                      _applyFilters();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Duration Filter
          Row(
            children: [
              const Text('Duration: '),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _duration,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Durations')),
                    DropdownMenuItem(value: 'short', child: Text('Short (< 2 hours)')),
                    DropdownMenuItem(value: 'medium', child: Text('Medium (2-3 hours)')),
                    DropdownMenuItem(value: 'long', child: Text('Long (> 3 hours)')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _duration = value ?? 'all';
                      _applyFilters();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Sort By Filter
          Row(
            children: [
              const Text('Sort By: '),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _sortBy,
                  items: const [
                    DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
                    DropdownMenuItem(value: 'rating', child: Text('Rating')),
                    DropdownMenuItem(value: 'price-low-high', child: Text('Price: Low to High')),
                    DropdownMenuItem(value: 'price-high-low', child: Text('Price: High to Low')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value ?? 'popularity';
                      _applyFilters();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPujaList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredPujas.length,
      itemBuilder: (context, index) {
        final puja = _filteredPujas[index];
        return _buildPujaCard(puja);
      },
    );
  }

  Widget _buildPujaCard(Map<String, dynamic> puja) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context, 
            '/product-detail',
            arguments: {'id': puja['id'], 'type': 'puja'},
          );
        },
        child: Column(
          children: [
            // Puja image
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/${puja['image'] ?? 'satyanarayan.jpg'}',
                  ),
                  fit: BoxFit.cover,
                  onError: (_, __) {},
                ),
              ),
              child: Stack(
                children: [
                  // Rating badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                            '${puja['rating'] ?? 4.5}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Puja details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    puja['name'] ?? 'Puja Name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Duration: ${puja['duration'] ?? 2} hours',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Text(
                        '₹${puja['price'] ?? 1100}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF317BEA),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, 
                          '/product-detail',
                          arguments: {'id': puja['id'], 'type': 'puja'},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000),
                      ),
                      child: const Text('Book Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No pujas found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your search or filters',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _priceRange = 'all';
                _duration = 'all';
                _occasion = 'all';
                _sortBy = 'popularity';
                _showFilters = false;
                _applyFilters();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
} 