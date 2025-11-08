// FILE: lib/widgets/modals/start_journey_modal.dart
import 'package:flutter/material.dart';
import '../success_dialog.dart';
import '../modal_handle.dart';

class StartJourneyModal extends StatefulWidget {
  final Map<String, dynamic> journey;

  const StartJourneyModal({super.key, required this.journey});

  @override
  State<StartJourneyModal> createState() => _StartJourneyModalState();
}

class _StartJourneyModalState extends State<StartJourneyModal> {
  final _formKey = GlobalKey<FormState>();
  final _odometerController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isLoading = false;
  bool _vehicleInspected = false;
  bool _cargoSecured = false;

  @override
  void dispose() {
    _odometerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _startJourney() async {
    if (_formKey.currentState!.validate()) {
      if (!_vehicleInspected || !_cargoSecured) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete all safety checks'),
            backgroundColor: Colors.orange,
          ),
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
          title: 'Journey Started!',
          message: 'Drive safely and keep customers updated',
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
                      child: const Icon(Icons.play_arrow, color: Colors.green, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Journey',
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

                // Journey Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        Icons.location_on,
                        'From',
                        widget.journey['from'],
                      ),
                      const Divider(height: 16),
                      _buildInfoRow(
                        Icons.flag,
                        'To',
                        widget.journey['to'],
                      ),
                      const Divider(height: 16),
                      _buildInfoRow(
                        Icons.straighten,
                        'Distance',
                        widget.journey['distance'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Safety Checklist
                Text(
                  'Pre-Journey Checklist',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: _vehicleInspected,
                  onChanged: (value) {
                    setState(() {
                      _vehicleInspected = value ?? false;
                    });
                  },
                  title: const Text('Vehicle Inspected'),
                  subtitle: const Text('Tires, lights, fuel, etc.'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: _cargoSecured,
                  onChanged: (value) {
                    setState(() {
                      _cargoSecured = value ?? false;
                    });
                  },
                  title: const Text('Cargo Secured'),
                  subtitle: const Text('Properly loaded and fastened'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),

                // Odometer Reading
                TextFormField(
                  controller: _odometerController,
                  decoration: InputDecoration(
                    labelText: 'Starting Odometer Reading (km)',
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

                // Notes
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: 'Notes (Optional)',
                    hintText: 'Any observations or concerns',
                    prefixIcon: const Icon(Icons.notes),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: _isLoading ? null : _startJourney,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Journey'),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}