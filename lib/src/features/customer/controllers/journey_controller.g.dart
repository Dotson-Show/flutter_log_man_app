// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DownloadProgress)
const downloadProgressProvider = DownloadProgressProvider._();

final class DownloadProgressProvider
    extends $NotifierProvider<DownloadProgress, double?> {
  const DownloadProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadProgressHash();

  @$internal
  @override
  DownloadProgress create() => DownloadProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double?>(value),
    );
  }
}

String _$downloadProgressHash() => r'3871bd3fa449f9fb2f6aa5ac6cb8bf713adedeb3';

abstract class _$DownloadProgress extends $Notifier<double?> {
  double? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<double?, double?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double?, double?>,
              double?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DownloadCancelToken)
const downloadCancelTokenProvider = DownloadCancelTokenProvider._();

final class DownloadCancelTokenProvider
    extends $NotifierProvider<DownloadCancelToken, CancelToken?> {
  const DownloadCancelTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadCancelTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadCancelTokenHash();

  @$internal
  @override
  DownloadCancelToken create() => DownloadCancelToken();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelToken? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelToken?>(value),
    );
  }
}

String _$downloadCancelTokenHash() =>
    r'05cd97d0db46670481d9146dd89f77d18fb43bdc';

abstract class _$DownloadCancelToken extends $Notifier<CancelToken?> {
  CancelToken? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CancelToken?, CancelToken?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CancelToken?, CancelToken?>,
              CancelToken?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(JourneyController)
const journeyControllerProvider = JourneyControllerProvider._();

final class JourneyControllerProvider
    extends
        $AsyncNotifierProvider<
          JourneyController,
          (List<Journey>, Pagination)?
        > {
  const JourneyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journeyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journeyControllerHash();

  @$internal
  @override
  JourneyController create() => JourneyController();
}

String _$journeyControllerHash() => r'9e90b3aa5e78ccea7196323beee376345264d92c';

abstract class _$JourneyController
    extends $AsyncNotifier<(List<Journey>, Pagination)?> {
  FutureOr<(List<Journey>, Pagination)?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<(List<Journey>, Pagination)?>,
              (List<Journey>, Pagination)?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<(List<Journey>, Pagination)?>,
                (List<Journey>, Pagination)?
              >,
              AsyncValue<(List<Journey>, Pagination)?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
