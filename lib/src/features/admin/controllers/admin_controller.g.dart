// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminApprovalsController)
const adminApprovalsControllerProvider = AdminApprovalsControllerProvider._();

final class AdminApprovalsControllerProvider
    extends
        $AsyncNotifierProvider<
          AdminApprovalsController,
          Map<String, List<Map<String, dynamic>>>
        > {
  const AdminApprovalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminApprovalsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminApprovalsControllerHash();

  @$internal
  @override
  AdminApprovalsController create() => AdminApprovalsController();
}

String _$adminApprovalsControllerHash() =>
    r'c9d57c223f2f79cfe90505b6c9db58a01f1cc36d';

abstract class _$AdminApprovalsController
    extends $AsyncNotifier<Map<String, List<Map<String, dynamic>>>> {
  FutureOr<Map<String, List<Map<String, dynamic>>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<Map<String, dynamic>>>>,
              Map<String, List<Map<String, dynamic>>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<Map<String, dynamic>>>>,
                Map<String, List<Map<String, dynamic>>>
              >,
              AsyncValue<Map<String, List<Map<String, dynamic>>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AdminPaymentsController)
const adminPaymentsControllerProvider = AdminPaymentsControllerProvider._();

final class AdminPaymentsControllerProvider
    extends $AsyncNotifierProvider<AdminPaymentsController, List<Payment>> {
  const AdminPaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPaymentsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPaymentsControllerHash();

  @$internal
  @override
  AdminPaymentsController create() => AdminPaymentsController();
}

String _$adminPaymentsControllerHash() =>
    r'13d5859079e41e6f46283543886111289d617f67';

abstract class _$AdminPaymentsController extends $AsyncNotifier<List<Payment>> {
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

@ProviderFor(AdminUsersController)
const adminUsersControllerProvider = AdminUsersControllerProvider._();

final class AdminUsersControllerProvider
    extends $AsyncNotifierProvider<AdminUsersController, List<User>> {
  const AdminUsersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminUsersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminUsersControllerHash();

  @$internal
  @override
  AdminUsersController create() => AdminUsersController();
}

String _$adminUsersControllerHash() =>
    r'442fe525b099c1fc57709f2453ce61b80260d101';

abstract class _$AdminUsersController extends $AsyncNotifier<List<User>> {
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

@ProviderFor(AdminAnalyticsController)
const adminAnalyticsControllerProvider = AdminAnalyticsControllerProvider._();

final class AdminAnalyticsControllerProvider
    extends
        $AsyncNotifierProvider<AdminAnalyticsController, Map<String, dynamic>> {
  const AdminAnalyticsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAnalyticsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAnalyticsControllerHash();

  @$internal
  @override
  AdminAnalyticsController create() => AdminAnalyticsController();
}

String _$adminAnalyticsControllerHash() =>
    r'c61fcf4cefb6637823594e7a81443088615aa561';

abstract class _$AdminAnalyticsController
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
