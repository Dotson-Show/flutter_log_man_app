// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryInitialized)
const historyInitializedProvider = HistoryInitializedProvider._();

final class HistoryInitializedProvider
    extends $NotifierProvider<HistoryInitialized, bool> {
  const HistoryInitializedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyInitializedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyInitializedHash();

  @$internal
  @override
  HistoryInitialized create() => HistoryInitialized();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$historyInitializedHash() =>
    r'a3a1df72ef5fd84e26b5a91f20237ee385d6c585';

abstract class _$HistoryInitialized extends $Notifier<bool> {
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

@ProviderFor(HistoryFilter)
const historyFilterProvider = HistoryFilterProvider._();

final class HistoryFilterProvider
    extends $NotifierProvider<HistoryFilter, String> {
  const HistoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyFilterHash();

  @$internal
  @override
  HistoryFilter create() => HistoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$historyFilterHash() => r'979b49c131f8c2fc5fdb4f374f72dab5b8cb6216';

abstract class _$HistoryFilter extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
