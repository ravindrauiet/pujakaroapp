import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Order Details',
      currentIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header Card
            _buildOrderHeaderCard(),
            
            const SizedBox(height: 16),
            
            // Order Details Card
            _buildOrderDetailsCard(),
            
            const SizedBox(height: 16),
            
            // Customer Details Card
            _buildCustomerDetailsCard(),
            
            const SizedBox(height: 16),
            
            // Payment Details Card
            _buildPaymentDetailsCard(),
            
            const SizedBox(height: 16),
            
            // Action Buttons
            _buildActionButtons(context),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeaderCard() {
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking #${order['id']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5F4B32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Placed on ${order['date'] ?? 'Date not set'}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order['status'] ?? 'pending').withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusDisplayName(order['status'] ?? 'pending'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(order['status'] ?? 'pending'),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Puja Name
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6E5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.celebration,
                    color: Color(0xFFFB9548),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['pujaName'] ?? 'Puja Name Not Available',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5F4B32),
                        ),
                      ),
                      if (order['pujaType'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          order['pujaType'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5F4B32),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Date and Time
            if (order['date'] != null || order['time'] != null) ...[
              _buildDetailRow(
                icon: Icons.calendar_today,
                label: 'Date & Time',
                value: '${order['date'] ?? 'Date not set'}${order['time'] != null ? ' at ${order['time']}' : ''}',
              ),
              const SizedBox(height: 12),
            ],
            
            // Duration
            if (order['duration'] != null) ...[
              _buildDetailRow(
                icon: Icons.timer,
                label: 'Duration',
                value: order['duration'],
              ),
              const SizedBox(height: 12),
            ],
            
            // Number of People
            if (order['numberOfPeople'] != null) ...[
              _buildDetailRow(
                icon: Icons.people,
                label: 'Number of People',
                value: '${order['numberOfPeople']} people',
              ),
              const SizedBox(height: 12),
            ],
            
            // Special Requirements
            if (order['specialRequirements'] != null && order['specialRequirements'].isNotEmpty) ...[
              _buildDetailRow(
                icon: Icons.note,
                label: 'Special Requirements',
                value: order['specialRequirements'],
              ),
              const SizedBox(height: 12),
            ],
            
            // Puja Items
            if (order['pujaItems'] != null && order['pujaItems'].isNotEmpty) ...[
              _buildDetailRow(
                icon: Icons.inventory,
                label: 'Puja Items',
                value: order['pujaItems'].join(', '),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsCard() {
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5F4B32),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Customer Name
            if (order['customerName'] != null) ...[
              _buildDetailRow(
                icon: Icons.person,
                label: 'Name',
                value: order['customerName'],
              ),
              const SizedBox(height: 12),
            ],
            
            // Phone Number
            if (order['phone'] != null) ...[
              _buildDetailRow(
                icon: Icons.phone,
                label: 'Phone',
                value: order['phone'],
              ),
              const SizedBox(height: 12),
            ],
            
            // Email
            if (order['email'] != null) ...[
              _buildDetailRow(
                icon: Icons.email,
                label: 'Email',
                value: order['email'],
              ),
              const SizedBox(height: 12),
            ],
            
            // Address
            if (order['address'] != null) ...[
              _buildDetailRow(
                icon: Icons.location_on,
                label: 'Address',
                value: '${order['address']}, ${order['city'] ?? ''}, ${order['state'] ?? ''}',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5F4B32),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Base Price
            if (order['price'] != null) ...[
              _buildPaymentRow(
                label: 'Base Price',
                value: '₹${order['price']}',
                isTotal: false,
              ),
              const SizedBox(height: 8),
            ],
            
            // Discount
            if (order['discount'] != null && order['discount'] > 0) ...[
              _buildPaymentRow(
                label: 'Discount',
                value: '-₹${order['discount']}',
                isTotal: false,
                isDiscount: true,
              ),
              const SizedBox(height: 8),
            ],
            
            // Additional Charges
            if (order['additionalCharges'] != null && order['additionalCharges'] > 0) ...[
              _buildPaymentRow(
                label: 'Additional Charges',
                value: '₹${order['additionalCharges']}',
                isTotal: false,
              ),
              const SizedBox(height: 8),
            ],
            
            const Divider(height: 24),
            
            // Final Amount
            _buildPaymentRow(
              label: 'Total Amount',
              value: '₹${(order['finalPrice'] ?? order['price'] ?? 0).toStringAsFixed(0)}',
              isTotal: true,
            ),
            
            const SizedBox(height: 16),
            
            // Payment Status
            if (order['paymentStatus'] != null) ...[
              Row(
                children: [
                  Icon(
                    order['paymentStatus'] == 'paid' ? Icons.check_circle : Icons.pending,
                    color: order['paymentStatus'] == 'paid' ? Colors.green : Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Payment ${order['paymentStatus'] == 'paid' ? 'Completed' : 'Pending'}',
                    style: TextStyle(
                      color: order['paymentStatus'] == 'paid' ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Download Receipt Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Download receipt coming soon')),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Download Receipt'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF317BEA),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Contact Support Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact support coming soon')),
              );
            },
            icon: const Icon(Icons.support_agent),
            label: const Text('Contact Support'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF8B0000),
              side: const BorderSide(color: Color(0xFF8B0000)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFFFB9548),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF5F4B32),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow({
    required String label,
    required String value,
    required bool isTotal,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? const Color(0xFF5F4B32) : Colors.grey.shade600,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal 
                ? const Color(0xFF8B0000)
                : isDiscount 
                    ? Colors.green 
                    : const Color(0xFF5F4B32),
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green.shade700;
      case 'confirmed':
        return Colors.blue.shade700;
      case 'pending':
        return Colors.orange.shade800;
      case 'cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'confirmed':
        return 'Confirmed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
}
