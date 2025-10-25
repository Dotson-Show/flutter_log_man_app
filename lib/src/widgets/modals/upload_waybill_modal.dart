// FILE: lib/widgets/modals/upload_waybill_modal.dart
import 'package:flutter/material.dart';
import '../success_dialog.dart';
import '../modal_handle.dart';

class UploadWaybillModal extends StatefulWidget {
  const UploadWaybillModal({super.key});

  @override
  State<UploadWaybillModal> createState() => _UploadWaybillModalState();
}

class _UploadWaybillModalState extends State<UploadWaybillModal> {
  final _formKey = GlobalKey<FormState>();
  final _waybillNumberController = TextEditingController();
  bool _isLoading = false;
  String? _selectedFileName;

  @override
  void dispose() {
    _waybillNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    // Add file_picker package and implement file picking
    // For now, just simulate
    setState(() {
      _selectedFileName = 'waybill_document.pdf';
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pop(context);
        showSuccessDialog(
          context: context,
          title: 'Success!',
          message: 'Waybill uploaded successfully',
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
                  'Upload Waybill',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _waybillNumberController,
                  decoration: InputDecoration(
                    labelText: 'Waybill Number',
                    hintText: 'Enter waybill number',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter waybill number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: Text(_selectedFileName ?? 'Select Document'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                if (_selectedFileName != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedFileName!,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
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
                      : const Text('Upload'),
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