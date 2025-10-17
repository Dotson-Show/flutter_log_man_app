// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorService)
const vendorServiceProvider = VendorServiceProvider._();

final class VendorServiceProvider
    extends $FunctionalProvider<VendorService, VendorService, VendorService>
    with $Provider<VendorService> {
  const VendorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorServiceHash();

  @$internal
  @override
  $ProviderElement<VendorService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VendorService create(Ref ref) {
    return vendorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorService>(value),
    );
  }
}

String _$vendorServiceHash() => r'6702e013fac8573ecb4bdf5c5789e8d38d930535';
