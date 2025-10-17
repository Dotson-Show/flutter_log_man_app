// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_onboarding_screen.dart';

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
    r'36bdd39ffa35e1c15cd1ea8f28a36917c994f464';

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
