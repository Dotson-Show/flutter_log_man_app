// FILE: lib/widgets/modals/complete_journey_modal.dart
import 'package:flutter/material.dart';
import '../success_dialog.dart';
import '../modal_handle.dart';

class CompleteJourneyModal extends StatefulWidget {
  final Map<String, dynamic> journey;

  const CompleteJourneyModal({super.key, required this.journey});

  @override
  State<CompleteJourneyModal> createState() => _CompleteJourneyModalState();
}

class _CompleteJourneyModalState extends State<CompleteJourneyModal> {
  final _formKey = GlobalKey<FormState>();
  final _odometerController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isLoading = false;
  bool _cargoDelivered = false;
  bool _noIncidents = false;
  bool _receiverSigned = false;

  @override
  void dispose() {
    _odometerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _completeJourney() async {
    if (_formKey.currentState!.validate()) {
      if (!_cargoDelivered || !_noIncidents || !_receiverSigned) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete all delivery confirmations'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pop(context);
        showSuccessDialog(
          context: context,
          title: 'Journey Completed!',
          message: 'Great job! Your payment will be processed soon.',
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete Journey',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.journey['cargo'],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Delivery Confirmation
                Text(
                  'Delivery Confirmation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: _cargoDelivered,
                  onChanged: (value) {
                    setState(() {
                      _cargoDelivered = value ?? false;
                    });
                  },
                  title: const Text('Cargo Delivered Successfully'),
                  subtitle: const Text('All items delivered in good condition'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: _noIncidents,
                  onChanged: (value) {
                    setState(() {
                      _noIncidents = value ?? false;
                    });
                  },
                  title: const Text('No Incidents During Transit'),
                  subtitle: const Text('Journey completed without issues'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: _receiverSigned,
                  onChanged: (value) {
                    setState(() {
                      _receiverSigned = value ?? false;
                    });
                  },
                  title: const Text('Receiver Signature Obtained'),
                  subtitle: const Text('Delivery receipt signed'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),

                // Ending Odometer
                TextFormField(
                  controller: _odometerController,
                  decoration: InputDecoration(
                    labelText: 'Ending Odometer Reading (km)',
                    hintText: 'Enter current odometer reading',
                    prefixIcon: const Icon(Icons.speed),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter odometer reading';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Delivery Notes
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: 'Delivery Notes (Optional)',
                    hintText: 'Any observations or feedback',
                    prefixIcon: const Icon(Icons.notes),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: _isLoading ? null : _completeJourney,
                  icon: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Icon(Icons.check_circle),
                  label: const Text('Complete Journey'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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