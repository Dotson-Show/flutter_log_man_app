// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LandingController)
const landingControllerProvider = LandingControllerProvider._();

final class LandingControllerProvider
    extends $NotifierProvider<LandingController, void> {
  const LandingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landingControllerHash();

  @$internal
  @override
  LandingController create() => LandingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$landingControllerHash() => r'656eda01aba1304af8097a2afb7b1ae145325538';

abstract class _$LandingController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
