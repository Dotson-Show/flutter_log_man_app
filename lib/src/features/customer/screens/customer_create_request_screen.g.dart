// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_create_request_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateJourneyLoading)
const createJourneyLoadingProvider = CreateJourneyLoadingProvider._();

final class CreateJourneyLoadingProvider
    extends $NotifierProvider<CreateJourneyLoading, bool> {
  const CreateJourneyLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createJourneyLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createJourneyLoadingHash();

  @$internal
  @override
  CreateJourneyLoading create() => CreateJourneyLoading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$createJourneyLoadingHash() =>
    r'1992ea329c910b6f4fb0fdd179658c6552998afb';

abstract class _$CreateJourneyLoading extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
