import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Rahul Sharma',
    'email': 'rahul.sharma@example.com',
    'phone': '+91 98765 43210',
    'address': '123 Spiritual Lane, Mumbai, India',
    'memberSince': 'January 2023',
    'profileImage': null, // No image, will use initials
  };

  // Mock order history
  final List<Map<String, dynamic>> _orderHistory = [
    {
      'id': 'ORD-2023-001',
      'date': '15 Jun 2023',
      'items': ['Satyanarayan Puja', 'Brass Diya Set'],
      'status': 'Completed',
      'amount': '₹1,999',
    },
    {
      'id': 'ORD-2023-002',
      'date': '28 May 2023',
      'items': ['Ganesh Puja', 'Incense Sticks Bundle'],
      'status': 'Completed',
      'amount': '₹1,499',
    },
    {
      'id': 'ORD-2023-003',
      'date': '10 Jul 2023',
      'items': ['Rudraksha Mala', 'Silver Puja Thali'],
      'status': 'Processing',
      'amount': '₹2,499',
    },
  ];

  // Mock saved addresses
  final List<Map<String, dynamic>> _savedAddresses = [
    {
      'type': 'Home',
      'address': '123 Spiritual Lane, Andheri East, Mumbai, Maharashtra - 400069',
      'isDefault': true,
    },
    {
      'type': 'Office',
      'address': '456 Corporate Park, Powai, Mumbai, Maharashtra - 400076',
      'isDefault': false,
    },
  ];

  // Mock saved payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'Credit Card',
      'info': '**** **** **** 1234',
      'expiry': '12/25',
      'isDefault': true,
    },
    {
      'type': 'UPI',
      'info': 'rahul@upi',
      'expiry': '',
      'isDefault': false,
    },
  ];

  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF8B0000),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF5F4B32)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          _buildProfileHeader(),
          
          // Tabs
          Container(
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
            child: Row(
              children: [
                _buildTabItem(0, 'Orders'),
                _buildTabItem(1, 'Addresses'),
                _buildTabItem(2, 'Payments'),
                _buildTabItem(3, 'Settings'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Profile tab is selected
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
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/shop');
          } else if (index == 2) {
            // Already on profile
          }
        },
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xFFFFF6E5),
            child: Text(
              _userData['name'].toString().split(' ').map((e) => e[0]).join(''),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B0000),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // User Name
          Text(
            _userData['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5F4B32),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // User Email
          Text(
            _userData['email'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Member Since
          Text(
            'Member since ${_userData['memberSince']}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Edit Profile Button
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile coming soon')),
              );
            },
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF8B0000),
              side: const BorderSide(color: Color(0xFF8B0000)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabItem(int index, String title) {
    final isSelected = _selectedTabIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFF8B0000) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF8B0000) : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOrdersTab();
      case 1:
        return _buildAddressesTab();
      case 2:
        return _buildPaymentsTab();
      case 3:
        return _buildSettingsTab();
      default:
        return _buildOrdersTab();
    }
  }
  
  Widget _buildOrdersTab() {
    return _orderHistory.isEmpty
        ? _buildEmptyState(
            icon: Icons.shopping_bag,
            title: 'No Orders Yet',
            description: 'Your order history will appear here once you make a purchase.',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _orderHistory.length,
            itemBuilder: (context, index) {
              final order = _orderHistory[index];
              
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
                    // Order Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF6E5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order['id']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5F4B32),
                            ),
                          ),
                          Text(
                            order['date'],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Order Items
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Items
                          ...List.generate(
                            (order['items'] as List).length,
                            (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: Color(0xFFFB9548),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    order['items'][i],
                                    style: const TextStyle(
                                      color: Color(0xFF5F4B32),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Order Footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: order['status'] == 'Completed'
                                      ? const Color(0xFFE8F5E9)
                                      : const Color(0xFFFFF8E1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  order['status'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: order['status'] == 'Completed'
                                        ? Colors.green.shade700
                                        : Colors.orange.shade800,
                                  ),
                                ),
                              ),
                              
                              // Amount
                              Text(
                                order['amount'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B0000),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // View Details Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Order details coming soon')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF317BEA),
                                side: const BorderSide(color: Color(0xFF317BEA)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('View Details'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
  
  Widget _buildAddressesTab() {
    return _savedAddresses.isEmpty
        ? _buildEmptyState(
            icon: Icons.location_on,
            title: 'No Addresses Saved',
            description: 'Add a delivery address to make checkout faster.',
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Add New Address Button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add address coming soon')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF317BEA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Addresses
              ...List.generate(
                _savedAddresses.length,
                (index) {
                  final address = _savedAddresses[index];
                  
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Address Type and Default Badge
                          Row(
                            children: [
                              Text(
                                address['type'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5F4B32),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (address['isDefault'])
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF6E5),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: const Color(0xFFFB9548),
                                    ),
                                  ),
                                  child: const Text(
                                    'Default',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFB9548),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Address
                          Text(
                            address['address'],
                            style: const TextStyle(
                              color: Color(0xFF5F4B32),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Edit address coming soon')),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF317BEA),
                                    side: const BorderSide(color: Color(0xFF317BEA)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Edit'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Delete address coming soon')),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
  
  Widget _buildPaymentsTab() {
    return _paymentMethods.isEmpty
        ? _buildEmptyState(
            icon: Icons.payment,
            title: 'No Payment Methods',
            description: 'Add a payment method to make checkout faster.',
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Add New Payment Button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add payment method coming soon')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Payment Method'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF317BEA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Payment Methods
              ...List.generate(
                _paymentMethods.length,
                (index) {
                  final payment = _paymentMethods[index];
                  
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Payment Icon
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF6E5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              payment['type'] == 'Credit Card'
                                  ? Icons.credit_card
                                  : Icons.account_balance,
                              color: const Color(0xFFFB9548),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Payment Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Payment Type and Default Badge
                                Row(
                                  children: [
                                    Text(
                                      payment['type'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5F4B32),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (payment['isDefault'])
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFF6E5),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: const Color(0xFFFB9548),
                                          ),
                                        ),
                                        child: const Text(
                                          'Default',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFB9548),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                
                                const SizedBox(height: 4),
                                
                                // Card Info
                                Text(
                                  payment['info'],
                                  style: const TextStyle(
                                    color: Color(0xFF5F4B32),
                                  ),
                                ),
                                
                                if (payment['expiry'].isNotEmpty)
                                  Text(
                                    'Expires: ${payment['expiry']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Delete payment method coming soon')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
  
  Widget _buildSettingsTab() {
    final settingsItems = [
      {
        'title': 'Account Settings',
        'icon': Icons.person_outline,
        'items': [
          'Edit Profile',
          'Change Password',
          'Notifications',
          'Language',
        ],
      },
      {
        'title': 'App Settings',
        'icon': Icons.settings_outlined,
        'items': [
          'Dark Mode',
          'Privacy Settings',
          'Clear Cache',
        ],
      },
      {
        'title': 'Help & Support',
        'icon': Icons.help_outline,
        'items': [
          'FAQs',
          'Contact Support',
          'Terms & Conditions',
          'Privacy Policy',
        ],
      },
    ];
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: settingsItems.length,
      itemBuilder: (context, index) {
        final settingGroup = settingsItems[index];
        
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
              // Group Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      settingGroup['icon'] as IconData,
                      color: const Color(0xFF8B0000),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      settingGroup['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Divider
              const Divider(height: 1),
              
              // Settings Items
              ...List.generate(
                (settingGroup['items'] as List).length,
                (i) => Column(
                  children: [
                    ListTile(
                      title: Text(
                        (settingGroup['items'] as List)[i],
                        style: const TextStyle(
                          color: Color(0xFF5F4B32),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF5F4B32),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${(settingGroup['items'] as List)[i]} coming soon')),
                        );
                      },
                    ),
                    if (i < (settingGroup['items'] as List).length - 1)
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5F4B32),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
