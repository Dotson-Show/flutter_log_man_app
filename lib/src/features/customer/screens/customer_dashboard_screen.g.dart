// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dashboard_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardInitialized)
const dashboardInitializedProvider = DashboardInitializedProvider._();

final class DashboardInitializedProvider
    extends $NotifierProvider<DashboardInitialized, bool> {
  const DashboardInitializedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardInitializedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardInitializedHash();

  @$internal
  @override
  DashboardInitialized create() => DashboardInitialized();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$dashboardInitializedHash() =>
    r'34a9fdac93f7d3e9bad73b15674a10a83f138cde';

abstract class _$DashboardInitialized extends $Notifier<bool> {
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
