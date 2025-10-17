// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorOnboardingController)
const vendorOnboardingControllerProvider =
    VendorOnboardingControllerProvider._();

final class VendorOnboardingControllerProvider
    extends $NotifierProvider<VendorOnboardingController, AsyncValue<void>> {
  const VendorOnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorOnboardingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorOnboardingControllerHash();

  @$internal
  @override
  VendorOnboardingController create() => VendorOnboardingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$vendorOnboardingControllerHash() =>
    r'ed20c5d6fabe5f2fe2c399d79a6b7bacd50682f0';

abstract class _$VendorOnboardingController
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

@ProviderFor(VendorRequestsController)
const vendorRequestsControllerProvider = VendorRequestsControllerProvider._();

final class VendorRequestsControllerProvider
    extends $AsyncNotifierProvider<VendorRequestsController, List<Journey>> {
  const VendorRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorRequestsControllerHash();

  @$internal
  @override
  VendorRequestsController create() => VendorRequestsController();
}

String _$vendorRequestsControllerHash() =>
    r'c5aa3f8c736b3022ea890f46eafbf535352036d7';

abstract class _$VendorRequestsController
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

@ProviderFor(VendorDriversController)
const vendorDriversControllerProvider = VendorDriversControllerProvider._();

final class VendorDriversControllerProvider
    extends $AsyncNotifierProvider<VendorDriversController, List<User>> {
  const VendorDriversControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorDriversControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorDriversControllerHash();

  @$internal
  @override
  VendorDriversController create() => VendorDriversController();
}

String _$vendorDriversControllerHash() =>
    r'9f662467e81ee9811859274de026e303344e6462';

abstract class _$VendorDriversController extends $AsyncNotifier<List<User>> {
  FutureOr<List<User>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<User>>, List<User>>,
              AsyncValue<List<User>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(VendorWaybillsController)
const vendorWaybillsControllerProvider = VendorWaybillsControllerProvider._();

final class VendorWaybillsControllerProvider
    extends $AsyncNotifierProvider<VendorWaybillsController, List<Waybill>> {
  const VendorWaybillsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorWaybillsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorWaybillsControllerHash();

  @$internal
  @override
  VendorWaybillsController create() => VendorWaybillsController();
}

String _$vendorWaybillsControllerHash() =>
    r'0ba1fe9120041c42808a0ec90edcc3a64f68b465';

abstract class _$VendorWaybillsController
    extends $AsyncNotifier<List<Waybill>> {
  FutureOr<List<Waybill>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Waybill>>, List<Waybill>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Waybill>>, List<Waybill>>,
              AsyncValue<List<Waybill>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(VendorAnalyticsController)
const vendorAnalyticsControllerProvider = VendorAnalyticsControllerProvider._();

final class VendorAnalyticsControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorAnalyticsController,
          Map<String, dynamic>
        > {
  const VendorAnalyticsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorAnalyticsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorAnalyticsControllerHash();

  @$internal
  @override
  VendorAnalyticsController create() => VendorAnalyticsController();
}

String _$vendorAnalyticsControllerHash() =>
    r'9422a56afa2c36a7ccc99a7da466023994c8df29';

abstract class _$VendorAnalyticsController
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
