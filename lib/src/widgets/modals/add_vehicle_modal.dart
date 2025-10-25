// FILE: lib/widgets/modals/add_vehicle_modal.dart
import 'package:flutter/material.dart';
import '../success_dialog.dart';
import '../modal_handle.dart';

class AddVehicleModal extends StatefulWidget {
  const AddVehicleModal({super.key});

  @override
  State<AddVehicleModal> createState() => _AddVehicleModalState();
}

class _AddVehicleModalState extends State<AddVehicleModal> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNumberController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _vehicleTypeController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call - Replace with actual API
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pop(context);
        showSuccessDialog(
          context: context,
          title: 'Success!',
          message: 'Vehicle added successfully',
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
                  'Add New Vehicle',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _vehicleNumberController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Number',
                    hintText: 'e.g., ABC-123-XYZ',
                    prefixIcon: const Icon(Icons.confirmation_number),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _vehicleTypeController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Type',
                    hintText: 'e.g., Truck, Van, etc.',
                    prefixIcon: const Icon(Icons.local_shipping),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _capacityController,
                  decoration: InputDecoration(
                    labelText: 'Capacity (tons)',
                    hintText: 'e.g., 5',
                    prefixIcon: const Icon(Icons.scale),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _isLoading ? null : _submitForm,
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
                      : const Text('Add Vehicle'),
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
}