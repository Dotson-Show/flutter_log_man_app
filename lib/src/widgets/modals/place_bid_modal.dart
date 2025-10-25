// FILE: lib/widgets/modals/place_bid_modal.dart
import 'package:flutter/material.dart';
import '../success_dialog.dart';
import '../modal_handle.dart';

class PlaceBidModal extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  const PlaceBidModal({super.key, required this.vehicle});

  @override
  State<PlaceBidModal> createState() => _PlaceBidModalState();
}

class _PlaceBidModalState extends State<PlaceBidModal> {
  final _formKey = GlobalKey<FormState>();
  final _bidAmountController = TextEditingController();
  final _notesController = TextEditingController();
  String? selectedCargo;
  bool _isLoading = false;

  // Mock cargo list - replace with actual data
  final List<String> cargos = [
    'Electronics Shipment - Lagos to Abuja',
    'Building Materials - Lagos to PH',
    'Food Items - Abuja to Lagos',
  ];

  @override
  void dispose() {
    _bidAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitBid() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCargo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a cargo')),
        );
        return;
      }

      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pop(context);
        showSuccessDialog(
          context: context,
          title: 'Bid Placed!',
          message: 'Your bid has been sent to the vendor for review',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ModalHandle(),
                const SizedBox(height: 20),
                Text(
                  'Place Bid',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'For: ${widget.vehicle['name']}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Cargo',
                    hintText: 'Choose a cargo to ship',
                    prefixIcon: const Icon(Icons.inventory_2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  value: selectedCargo,
                  items: cargos.map((cargo) {
                    return DropdownMenuItem(
                      value: cargo,
                      child: Text(
                        cargo,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCargo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a cargo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bidAmountController,
                  decoration: InputDecoration(
                    labelText: 'Bid Amount (₦)',
                    hintText: 'Enter your bid amount',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    helperText: 'Suggested: ${widget.vehicle['pricePerKm']} per km',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bid amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: 'Additional Notes (Optional)',
                    hintText: 'Any special requirements or notes',
                    prefixIcon: const Icon(Icons.notes),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bid Summary',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Vehicle', widget.vehicle['name']),
                      _buildSummaryRow('Capacity', widget.vehicle['capacity']),
                      _buildSummaryRow('Location', widget.vehicle['location']),
                      _buildSummaryRow('Vendor', widget.vehicle['vendor']),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _isLoading ? null : _submitBid,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Submit Bid'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}