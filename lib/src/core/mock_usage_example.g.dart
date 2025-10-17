// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_usage_example.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Example of how to use the mock API service in your controllers
/// This shows how to replace your existing API calls with mock calls

@ProviderFor(MockUsageExample)
const mockUsageExampleProvider = MockUsageExampleProvider._();

/// Example of how to use the mock API service in your controllers
/// This shows how to replace your existing API calls with mock calls
final class MockUsageExampleProvider
    extends $AsyncNotifierProvider<MockUsageExample, Map<String, dynamic>> {
  /// Example of how to use the mock API service in your controllers
  /// This shows how to replace your existing API calls with mock calls
  const MockUsageExampleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockUsageExampleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockUsageExampleHash();

  @$internal
  @override
  MockUsageExample create() => MockUsageExample();
}

String _$mockUsageExampleHash() => r'481acec664c236c1ffd21f2cd3cc24e30184065e';

/// Example of how to use the mock API service in your controllers
/// This shows how to replace your existing API calls with mock calls

abstract class _$MockUsageExample extends $AsyncNotifier<Map<String, dynamic>> {
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
