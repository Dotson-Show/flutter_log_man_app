// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_detail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WaybillList)
const waybillListProvider = WaybillListFamily._();

final class WaybillListProvider
    extends $AsyncNotifierProvider<WaybillList, List<Waybill>> {
  const WaybillListProvider._({
    required WaybillListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'waybillListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waybillListHash();

  @override
  String toString() {
    return r'waybillListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WaybillList create() => WaybillList();

  @override
  bool operator ==(Object other) {
    return other is WaybillListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waybillListHash() => r'3e508ef7de59fae309afb444cefc7f42d2856e75';

final class WaybillListFamily extends $Family
    with
        $ClassFamilyOverride<
          WaybillList,
          AsyncValue<List<Waybill>>,
          List<Waybill>,
          FutureOr<List<Waybill>>,
          int
        > {
  const WaybillListFamily._()
    : super(
        retry: null,
        name: r'waybillListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WaybillListProvider call(int journeyId) =>
      WaybillListProvider._(argument: journeyId, from: this);

  @override
  String toString() => r'waybillListProvider';
}

abstract class _$WaybillList extends $AsyncNotifier<List<Waybill>> {
  late final _$args = ref.$arg as int;
  int get journeyId => _$args;

  FutureOr<List<Waybill>> build(int journeyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Waybill>>, List<Waybill>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Waybill>>, List<Waybill>>,
              AsyncValue<List<Waybill>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(JourneyDetail)
const journeyDetailProvider = JourneyDetailFamily._();

final class JourneyDetailProvider
    extends $AsyncNotifierProvider<JourneyDetail, Journey> {
  const JourneyDetailProvider._({
    required JourneyDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'journeyDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$journeyDetailHash();

  @override
  String toString() {
    return r'journeyDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  JourneyDetail create() => JourneyDetail();

  @override
  bool operator ==(Object other) {
    return other is JourneyDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journeyDetailHash() => r'37ebaba93b2e0306ccc55212f984343adb6b6ded';

final class JourneyDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          JourneyDetail,
          AsyncValue<Journey>,
          Journey,
          FutureOr<Journey>,
          int
        > {
  const JourneyDetailFamily._()
    : super(
        retry: null,
        name: r'journeyDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JourneyDetailProvider call(int journeyId) =>
      JourneyDetailProvider._(argument: journeyId, from: this);

  @override
  String toString() => r'journeyDetailProvider';
}

abstract class _$JourneyDetail extends $AsyncNotifier<Journey> {
  late final _$args = ref.$arg as int;
  int get journeyId => _$args;

  FutureOr<Journey> build(int journeyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Journey>, Journey>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Journey>, Journey>,
              AsyncValue<Journey>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UploadState)
const uploadStateProvider = UploadStateProvider._();

final class UploadStateProvider extends $NotifierProvider<UploadState, bool> {
  const UploadStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadStateHash();

  @$internal
  @override
  UploadState create() => UploadState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$uploadStateHash() => r'4a05bae7d8af6439c5bf1c8a6c9fe2532ced3fc7';

abstract class _$UploadState extends $Notifier<bool> {
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
