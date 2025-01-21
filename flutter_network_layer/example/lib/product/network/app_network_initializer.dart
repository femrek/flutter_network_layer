import 'package:flutter/widgets.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The network initializer for the app.
///
/// Creates an [INetworkInvoker] for the app.
abstract final class AppNetworkInitializer {
  /// Create a network manager.
  ///
  /// Creates a [DioNetworkInvoker] with the default log callback.
  static INetworkInvoker createNetworkInvoker() {
    return DioNetworkInvoker(onLog: _onLog);
  }

  static void _onLog(NetworkLog log) {
    assert(() {
      debugPrint('[${_right(12, log.type)}] ${log.message}');
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
