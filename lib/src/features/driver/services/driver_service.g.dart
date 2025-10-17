// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverService)
const driverServiceProvider = DriverServiceProvider._();

final class DriverServiceProvider
    extends $FunctionalProvider<DriverService, DriverService, DriverService>
    with $Provider<DriverService> {
  const DriverServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverServiceHash();

  @$internal
  @override
  $ProviderElement<DriverService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DriverService create(Ref ref) {
    return driverService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverService>(value),
    );
  }
}

String _$driverServiceHash() => r'fab0e38b80e4e481c29fd9bda75885b868497de4';
