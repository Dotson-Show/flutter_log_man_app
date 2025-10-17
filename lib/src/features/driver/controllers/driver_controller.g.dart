// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverOnboardingController)
const driverOnboardingControllerProvider =
    DriverOnboardingControllerProvider._();

final class DriverOnboardingControllerProvider
    extends $NotifierProvider<DriverOnboardingController, AsyncValue<void>> {
  const DriverOnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverOnboardingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverOnboardingControllerHash();

  @$internal
  @override
  DriverOnboardingController create() => DriverOnboardingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$driverOnboardingControllerHash() =>
    r'c7d7ed20203a3a926e6ac8a8dfb26f69d475db46';

abstract class _$DriverOnboardingController
    extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DriverJourneysController)
const driverJourneysControllerProvider = DriverJourneysControllerProvider._();

final class DriverJourneysControllerProvider
    extends $AsyncNotifierProvider<DriverJourneysController, List<Journey>> {
  const DriverJourneysControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverJourneysControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverJourneysControllerHash();

  @$internal
  @override
  DriverJourneysController create() => DriverJourneysController();
}

String _$driverJourneysControllerHash() =>
    r'2624371b688312e8fa51c6bbaa99f78bddf30e9b';

abstract class _$DriverJourneysController
    extends $AsyncNotifier<List<Journey>> {
  FutureOr<List<Journey>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Journey>>, List<Journey>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Journey>>, List<Journey>>,
              AsyncValue<List<Journey>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DriverPaymentsController)
const driverPaymentsControllerProvider = DriverPaymentsControllerProvider._();

final class DriverPaymentsControllerProvider
    extends $AsyncNotifierProvider<DriverPaymentsController, List<Payment>> {
  const DriverPaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverPaymentsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverPaymentsControllerHash();

  @$internal
  @override
  DriverPaymentsController create() => DriverPaymentsController();
}

String _$driverPaymentsControllerHash() =>
    r'252ac4e3eaf8d470849aa727f1bcb3f12d868920';

abstract class _$DriverPaymentsController
    extends $AsyncNotifier<List<Payment>> {
  FutureOr<List<Payment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Payment>>, List<Payment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Payment>>, List<Payment>>,
              AsyncValue<List<Payment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DriverAnalyticsController)
const driverAnalyticsControllerProvider = DriverAnalyticsControllerProvider._();

final class DriverAnalyticsControllerProvider
    extends
        $AsyncNotifierProvider<
          DriverAnalyticsController,
          Map<String, dynamic>
        > {
  const DriverAnalyticsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverAnalyticsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverAnalyticsControllerHash();

  @$internal
  @override
  DriverAnalyticsController create() => DriverAnalyticsController();
}

String _$driverAnalyticsControllerHash() =>
    r'deba697f642aa2250599fe7399bc7e97108da859';

abstract class _$DriverAnalyticsController
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
