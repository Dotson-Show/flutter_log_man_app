// lib/src/features/customer/services/journey_service.dart
import 'package:dio/dio.dart';
import '../../../core/api_client.dart';
import '../../../models/journey.dart';
import '../../../models/pagination.dart';
import '../../../models/waybill.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../../../utils/error_parser.dart';

class JourneyService {
  final ApiClient apiClient;
  JourneyService(this.apiClient);

  Future<(List<Journey>, Pagination)> getCustomerJourneys({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final res = await apiClient.dio.get(
        '/api/v1/journeys',
        queryParameters: {'page': page, 'per_page': perPage},
      );

      final data = res.data;
      final journeys = (data['items'] as List)
          .map((e) => Journey.fromJson(e))
          .toList();
      final pagination = Pagination.fromJson(data['pagination']);

      return (journeys, pagination);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<Journey> getJourneyDetail(int id) async {
    try {
      final res = await apiClient.dio.get('/api/v1/journeys/$id');
      return Journey.fromJson(res.data['journey']);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<Journey> createJourney({
    required String origin,
    required String destination,
    required String transportType,
    required DateTime scheduledAt,
  }) async {
    try {
      final res = await apiClient.dio.post('/api/v1/journeys', data: {
        'origin': origin,
        'destination': destination,
        'transport_type': transportType,
        'scheduled_at': scheduledAt.toIso8601String(),
      });
      return Journey.fromJson(res.data['journey']);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Waybill>> getWaybillsForJourney(int journeyId) async {
    try {
      final res = await apiClient.dio.get('/api/v1/waybills/$journeyId');
      return (res.data['items'] as List)
          .map((e) => Waybill.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> uploadWaybill({
    required int journeyId,
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'journey_id': journeyId,
        'file': await MultipartFile.fromFile(filePath),
      });
      await apiClient.dio.post('/api/v1/waybills/upload', data: formData);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<File> downloadWaybillFile(
      String fileUrl, {
        required void Function(int received, int total) onProgress,
        CancelToken? cancelToken,
      }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = fileUrl.split('/').last;
      final savePath = "${dir.path}/$fileName";

      await apiClient.dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );

      return File(savePath);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> openDownloadedFile(File file) async {
    await OpenFilex.open(file.path);
  }
}