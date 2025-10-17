import 'package:riverpod_annotation/riverpod_annotation.dart';

// Make sure this path matches your file name exactly
part 'landing_controller.g.dart';

@riverpod
class LandingController extends _$LandingController {
  @override
  void build() {
    // No state needed for now, but we can add animation states or other features later
  }

  void onLoginTap(void Function() callback) {
    // Could add analytics tracking or other logic here
    callback();
  }

  void onRegisterTap(void Function() callback) {
    // Could add analytics tracking or other logic here
    callback();
  }
}