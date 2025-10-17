// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminService)
const adminServiceProvider = AdminServiceProvider._();

final class AdminServiceProvider
    extends $FunctionalProvider<AdminService, AdminService, AdminService>
    with $Provider<AdminService> {
  const AdminServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminServiceHash();

  @$internal
  @override
  $ProviderElement<AdminService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdminService create(Ref ref) {
    return adminService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminService>(value),
    );
  }
}

String _$adminServiceHash() => r'8092b4f15ac9d4b04ba12d543c6a71388fa620d9';
