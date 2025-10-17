// lib/src/features/customer/controllers/journey_controller.dart
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/journey.dart';
import '../../../models/pagination.dart';
import '../../../models/waybill.dart';
import '../services/journey_service.dart';
import '../../../core/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

part 'journey_controller.g.dart';

// ✅ Declare progress-related providers using @riverpod generator syntax
@riverpod
class DownloadProgress extends _$DownloadProgress {
  @override
  double? build() => null;

  void updateProgress(double? progress) {
    state = progress;
  }

  void resetProgress() {
    state = null;
  }
}

@riverpod
class DownloadCancelToken extends _$DownloadCancelToken {
  @override
  CancelToken? build() => null;

  void setCancelToken(CancelToken? token) {
    state = token;
  }

  void clearCancelToken() {
    state = null;
  }
}

@riverpod
class JourneyController extends _$JourneyController {
  List<Journey> _journeys = [];
  Pagination? _pagination;

  @override
  FutureOr<(List<Journey>, Pagination)?> build() {
    // Initial state returns null, data will be loaded via fetchJourneys
    return null;
  }

  Future<void> fetchJourneys({int page = 1, bool append = false}) async {
    if (!append) {
      state = const AsyncLoading();
    }

    try {
      final service = JourneyService(ref.read(apiClientProvider));

      // Make sure your service returns a tuple or a record in Dart 3
      final (items, pagination) = await service.getCustomerJourneys(page: page);

      if (append) {
        _journeys.addAll(items);
      } else {
        _journeys = items;
      }

      _pagination = pagination;
      state = AsyncData((_journeys, _pagination!));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  bool canLoadMore() {
    if (_pagination == null) return false;
    return _pagination!.page < _pagination!.pages;
  }

  Future<Journey> fetchJourneyDetail(int id) async {
    final service = JourneyService(ref.read(apiClientProvider));
    return service.getJourneyDetail(id);
  }

  Future<List<Waybill>> fetchWaybills(int journeyId) async {
    final service = JourneyService(ref.read(apiClientProvider));
    return service.getWaybillsForJourney(journeyId);
  }

  Future<void> uploadWaybill(int journeyId, String filePath) async {
    final service = JourneyService(ref.read(apiClientProvider));
    await service.uploadWaybill(journeyId: journeyId, filePath: filePath);
  }

  Future<void> downloadAndOpenWaybill(String fileUrl) async {
    final service = JourneyService(ref.read(apiClientProvider));
    final file = await service.downloadWaybillFile(
      fileUrl,
      onProgress: (received, total) {
        // Default progress callback (can be empty)
      },
    );
    await service.openDownloadedFile(file);
  }

  Future<void> downloadAndOpenWaybillWithProgress(String fileUrl) async {
    final service = JourneyService(ref.read(apiClientProvider));

    // Create a cancel token
    final cancelToken = CancelToken();
    ref.read(downloadCancelTokenProvider.notifier).setCancelToken(cancelToken);

    // Reset progress
    ref.read(downloadProgressProvider.notifier).updateProgress(0.0);

    try {
      final file = await service.downloadWaybillFile(
        fileUrl,
        onProgress: (received, total) {
          if (total != -1) {
            ref.read(downloadProgressProvider.notifier).updateProgress(
                received / total);
          }
        },
        cancelToken: cancelToken,
      );

      // Clear after success
      ref.read(downloadProgressProvider.notifier).resetProgress();
      ref.read(downloadCancelTokenProvider.notifier).clearCancelToken();

      await service.openDownloadedFile(file);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint("Download cancelled");
      } else {
        rethrow;
      }
    } finally {
      // Ensure cleanup
      ref.read(downloadProgressProvider.notifier).resetProgress();
      ref.read(downloadCancelTokenProvider.notifier).clearCancelToken();
    }
  }

  Future<Journey> createJourney({
    required String origin,
    required String destination,
    required String transportType,
    required DateTime scheduledAt,
  }) async {
    final service = JourneyService(ref.read(apiClientProvider));
    return await service.createJourney(
      origin: origin,
      destination: destination,
      transportType: transportType,
      scheduledAt: scheduledAt,
    );
  }

  // Method to cancel ongoing download
  void cancelDownload() {
    final cancelToken = ref.read(downloadCancelTokenProvider);
    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel("Download cancelled by user");
    }
  }
}