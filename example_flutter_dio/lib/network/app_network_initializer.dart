import 'package:example_flutter_dio/logger/i_logger.dart';
import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:get_it/get_it.dart';

/// The network initializer for the app.
///
/// Creates an [INetworkInvoker] for the app.
abstract final class AppNetworkInitializer {
  static DioNetworkInvoker? _invoker;

  /// Create a network manager with [DioNetworkInvoker].
  ///
  /// Creates a [DioNetworkInvoker] with the default log callback.
  static DioNetworkInvoker createNetworkInvoker() {
    if (_invoker != null) {
      throw Exception('Network invoker already created');
    }
    return _invoker = DioNetworkInvoker(onLog: _onLog);
  }

  /// Initialize the network invoker.
  ///
  /// Initializes the invoker with the base URL from [AppNetworkConstants].
  static Future<void> initNetworkInvoker() async {
    final invoker = _invoker;
    if (invoker == null) {
      throw Exception('Network invoker has not been created');
    }
    await invoker.init(AppNetworkConstants.baseUrl);
  }

  static void _onLog(NetworkLog log) {
    GetIt.I<ILogger>().t(
      '[DioNetworkInvoker: ${log.type}] ${log.message}',
    );
  }
}
