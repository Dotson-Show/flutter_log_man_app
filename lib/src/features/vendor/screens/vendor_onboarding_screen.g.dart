// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_onboarding_screen.dart';

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
    r'aa2079fb9bd3587bb67444698b8e56ad20993b04';

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
