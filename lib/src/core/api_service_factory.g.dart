// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Factory that provides either mock or real API client based on configuration

@ProviderFor(ApiServiceFactory)
const apiServiceFactoryProvider = ApiServiceFactoryProvider._();

/// Factory that provides either mock or real API client based on configuration
final class ApiServiceFactoryProvider
    extends $NotifierProvider<ApiServiceFactory, dynamic> {
  /// Factory that provides either mock or real API client based on configuration
  const ApiServiceFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceFactoryHash();

  @$internal
  @override
  ApiServiceFactory create() => ApiServiceFactory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$apiServiceFactoryHash() => r'ea0053a9eab515c936f6a5a02e9b7a033356a9ef';

/// Factory that provides either mock or real API client based on configuration

abstract class _$ApiServiceFactory extends $Notifier<dynamic> {
  dynamic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<dynamic, dynamic>,
              dynamic,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
