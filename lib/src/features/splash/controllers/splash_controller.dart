import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage_service.dart';

part 'splash_controller.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  Future<String?> build() async {
    final storage = ref.read(storageServiceProvider);
    return await storage.getToken();
  }
}