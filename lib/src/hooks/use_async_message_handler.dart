// ========================================
// 6. ASYNC STATE HANDLER HOOK
// hooks/use_async_message_handler.dart
// ========================================

import 'package:flutter_hooks/flutter_hooks.dart';
import '../utils/error_parser.dart';

class AsyncMessageState {
  final String? errorMessage;
  final String? successMessage;
  final String? warningMessage;
  final String? infoMessage;
  final bool isLoading;
  final String? loadingMessage;

  AsyncMessageState({
    this.errorMessage,
    this.successMessage,
    this.warningMessage,
    this.infoMessage,
    this.isLoading = false,
    this.loadingMessage,
  });

  AsyncMessageState copyWith({
    String? errorMessage,
    String? successMessage,
    String? warningMessage,
    String? infoMessage,
    bool? isLoading,
    String? loadingMessage,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearWarning = false,
    bool clearInfo = false,
    bool clearLoading = false,
  }) {
    return AsyncMessageState(
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
      warningMessage: clearWarning ? null : (warningMessage ?? this.warningMessage),
      infoMessage: clearInfo ? null : (infoMessage ?? this.infoMessage),
      isLoading: clearLoading ? false : (isLoading ?? this.isLoading),
      loadingMessage: clearLoading ? null : (loadingMessage ?? this.loadingMessage),
    );
  }
}

class AsyncMessageController {
  AsyncMessageController(this._setState, this._state);

  final void Function(AsyncMessageState) _setState;
  final AsyncMessageState Function() _state;

  void showError(String message) {
    _setState(_state().copyWith(
      errorMessage: ErrorParser.parse(message),
      clearSuccess: true,
      clearWarning: true,
      clearInfo: true,
      clearLoading: true,
    ));
  }

  void showSuccess(String message, {Duration? autoDismiss}) {
    _setState(_state().copyWith(
      successMessage: message,
      clearError: true,
      clearWarning: true,
      clearInfo: true,
      clearLoading: true,
    ));

    if (autoDismiss != null) {
      Future.delayed(autoDismiss, clearSuccess);
    }
  }

  void showWarning(String message) {
    _setState(_state().copyWith(
      warningMessage: message,
      clearError: true,
      clearSuccess: true,
      clearInfo: true,
      clearLoading: true,
    ));
  }

  void showInfo(String message) {
    _setState(_state().copyWith(
      infoMessage: message,
      clearError: true,
      clearSuccess: true,
      clearWarning: true,
      clearLoading: true,
    ));
  }

  void showLoading(String message) {
    _setState(_state().copyWith(
      isLoading: true,
      loadingMessage: message,
      clearError: true,
      clearSuccess: true,
      clearWarning: true,
      clearInfo: true,
    ));
  }

  void clearError() {
    _setState(_state().copyWith(clearError: true));
  }

  void clearSuccess() {
    _setState(_state().copyWith(clearSuccess: true));
  }

  void clearLoading() {
    _setState(_state().copyWith(clearLoading: true));
  }

  void clearAll() {
    _setState(AsyncMessageState());
  }
}

(AsyncMessageState, AsyncMessageController) useAsyncMessageHandler() {
  final state = useState(AsyncMessageState());

  final controller = useMemoized(
        () => AsyncMessageController(
          (newState) => state.value = newState,
          () => state.value,
    ),
    [],
  );

  return (state.value, controller);
}