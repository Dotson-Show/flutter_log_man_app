import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_client.dart';

part 'file_upload_service.g.dart';

class FileUploadService {
  final ApiClient apiClient;
  FileUploadService(this.apiClient);

  /// Pick a single file (image or document)
  Future<File?> pickFile({
    FileType type = FileType.any,
    List<String> allowedExtensions = const [],
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions.isEmpty ? null : allowedExtensions,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick file: $e');
    }
  }

  /// Pick multiple files
  Future<List<File>> pickMultipleFiles({
    FileType type = FileType.any,
    List<String> allowedExtensions = const [],
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions.isEmpty ? null : allowedExtensions,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to pick files: $e');
    }
  }

  /// Pick an image file
  Future<File?> pickImage() async {
    return pickFile(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp'],
    );
  }

  /// Pick a document file
  Future<File?> pickDocument() async {
    return pickFile(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );
  }

  /// Upload a single file
  Future<String> uploadFile({
    required File file,
    required String endpoint,
    String? fieldName,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        fieldName ?? 'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        ...?additionalData,
      });

      final response = await apiClient.dio.post(endpoint, data: formData);
      return response.data['url'] ?? response.data['file_url'] ?? '';
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  /// Upload multiple files
  Future<List<String>> uploadMultipleFiles({
    required List<File> files,
    required String endpoint,
    String? fieldName,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?additionalData,
      });

      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry(
            '${fieldName ?? 'files'}[$i]',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ),
        );
      }

      final response = await apiClient.dio.post(endpoint, data: formData);
      final List<dynamic> urls = response.data['urls'] ?? response.data['file_urls'] ?? [];
      return urls.cast<String>();
    } catch (e) {
      throw Exception('Failed to upload files: $e');
    }
  }

  /// Upload waybill document
  Future<String> uploadWaybill({
    required File file,
    required int journeyId,
  }) async {
    return uploadFile(
      file: file,
      endpoint: '/api/v1/waybills/upload',
      fieldName: 'document',
      additionalData: {'journey_id': journeyId},
    );
  }

  /// Upload driver documents (license, vehicle docs)
  Future<Map<String, String>> uploadDriverDocuments({
    required File licenseDoc,
    required File vehicleDoc,
  }) async {
    try {
      final formData = FormData.fromMap({
        'license_doc': await MultipartFile.fromFile(
          licenseDoc.path,
          filename: licenseDoc.path.split('/').last,
        ),
        'vehicle_doc': await MultipartFile.fromFile(
          vehicleDoc.path,
          filename: vehicleDoc.path.split('/').last,
        ),
      });

      final response = await apiClient.dio.post('/api/v1/driver/documents/upload', data: formData);
      return {
        'license_url': response.data['license_url'] ?? '',
        'vehicle_url': response.data['vehicle_url'] ?? '',
      };
    } catch (e) {
      throw Exception('Failed to upload driver documents: $e');
    }
  }

  /// Upload proof document
  Future<String> uploadProof({
    required File file,
    required int journeyId,
  }) async {
    return uploadFile(
      file: file,
      endpoint: '/api/v1/driver/proof/upload',
      fieldName: 'proof',
      additionalData: {'journey_id': journeyId},
    );
  }
}

@riverpod
FileUploadService fileUploadService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FileUploadService(apiClient);
}




