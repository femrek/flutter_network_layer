import 'package:flutter/widgets.dart';
import 'package:network/network.dart';

/// The network initializer for the app.
///
/// Creates an [INetworkManager] for the app.
abstract final class AppNetworkInitializer {
  /// Create a network manager.
  ///
  /// Creates a [DioNetworkManager] with the default log callback.
  static INetworkManager createNetworkManager() {
    return DioNetworkManager(onDioLog: _onLog);
  }

  static void _onLog(LogLevel level, String message) {
    assert(() {
      debugPrint('[${_right(12, level.name)}] $message');
      return true;
    }(), '');
  }

  static String _right(int length, String content) {
    if (content.length >= length) {
      return content;
    }
    return content.padLeft(length - content.length);
  }
}
