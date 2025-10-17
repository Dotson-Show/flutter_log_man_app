// lib/src/features/customer/screens/create_request_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controllers/journey_controller.dart';
import 'package:go_router/go_router.dart';

part 'customer_create_request_screen.g.dart';

// Using generator-based provider to match your existing pattern
@riverpod
class CreateJourneyLoading extends _$CreateJourneyLoading {
  @override
  bool build() => false;

  void setLoading(bool loading) {
    state = loading;
  }
}

class CustomerCreateRequestScreen extends ConsumerStatefulWidget {
  const CustomerCreateRequestScreen({super.key});

  @override
  ConsumerState<CustomerCreateRequestScreen> createState() => _CustomerCreateRequestScreenState();
}

class _CustomerCreateRequestScreenState extends ConsumerState<CustomerCreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _originCtrl = TextEditingController();
  final _destCtrl = TextEditingController();
  String _transportType = 'truck';
  DateTime? _scheduled;

  @override
  void dispose() {
    _originCtrl.dispose();
    _destCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createJourneyLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Transport Request'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _originCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Origin',
                          hintText: 'Enter pickup location',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => (v?.isEmpty ?? true) ? 'Origin is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _destCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Destination',
                          hintText: 'Enter delivery location',
                          prefixIcon: Icon(Icons.location_off),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => (v?.isEmpty ?? true) ? 'Destination is required' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _transportType,
                        items: const [
                          DropdownMenuItem(value: 'truck', child: Text('Truck')),
                          DropdownMenuItem(value: 'car', child: Text('Car')),
                          DropdownMenuItem(value: 'van', child: Text('Van')),
                          DropdownMenuItem(value: 'motorcycle', child: Text('Motorcycle')),
                        ],
                        onChanged: (v) => setState(() => _transportType = v ?? 'truck'),
                        decoration: const InputDecoration(
                          labelText: 'Transport Type',
                          prefixIcon: Icon(Icons.local_shipping),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: isLoading ? null : _pickDateTime,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Scheduled Date & Time',
                            prefixIcon: Icon(Icons.schedule),
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _scheduled == null
                                ? 'Tap to select date and time'
                                : _formatDateTime(_scheduled!),
                            style: TextStyle(
                              color: _scheduled == null ? Colors.grey[600] : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _createRequest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text('Creating Request...'),
                  ],
                )
                    : const Text(
                  'Create Transport Request',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 9, minute: 0),
      );

      if (time != null && mounted) {
        setState(() {
          _scheduled = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _createRequest() async {
    if (!_formKey.currentState!.validate()) return;

    if (_scheduled == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time')),
      );
      return;
    }

    // Set loading state
    ref.read(createJourneyLoadingProvider.notifier).setLoading(true);

    try {
      final createdJourney = await ref
          .read(journeyControllerProvider.notifier)
          .createJourney(
        origin: _originCtrl.text.trim(),
        destination: _destCtrl.text.trim(),
        transportType: _transportType,
        scheduledAt: _scheduled!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transport request created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to journey detail
        context.go('/customer/journeys/${createdJourney.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create request: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Clear loading state
      if (mounted) {
        ref.read(createJourneyLoadingProvider.notifier).setLoading(false);
      }
    }
  }
}