// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprehensive_usage_example.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Comprehensive example showing how to use ALL endpoints from the Swagger file
/// This demonstrates the complete mock API system with all 49+ endpoints

@ProviderFor(ComprehensiveUsageExample)
const comprehensiveUsageExampleProvider = ComprehensiveUsageExampleProvider._();

/// Comprehensive example showing how to use ALL endpoints from the Swagger file
/// This demonstrates the complete mock API system with all 49+ endpoints
final class ComprehensiveUsageExampleProvider
    extends
        $AsyncNotifierProvider<
          ComprehensiveUsageExample,
          Map<String, dynamic>
        > {
  /// Comprehensive example showing how to use ALL endpoints from the Swagger file
  /// This demonstrates the complete mock API system with all 49+ endpoints
  const ComprehensiveUsageExampleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'comprehensiveUsageExampleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$comprehensiveUsageExampleHash();

  @$internal
  @override
  ComprehensiveUsageExample create() => ComprehensiveUsageExample();
}

String _$comprehensiveUsageExampleHash() =>
    r'5072a5e30cbd042e3320fe29ce393a091bb8e485';

/// Comprehensive example showing how to use ALL endpoints from the Swagger file
/// This demonstrates the complete mock API system with all 49+ endpoints

abstract class _$ComprehensiveUsageExample
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
