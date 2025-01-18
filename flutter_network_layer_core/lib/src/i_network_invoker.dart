import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// The interface to manage and perform the network requests.
abstract interface class INetworkInvoker {
  /// Initialize the network manager. Have to be overridden by the
  /// implementation for async initialization.
  Future<void> init(String baseUrl);

  /// Performs a request and returns the response.
  Future<ResponseResult<T>> request<T extends ResponseModel>(
      RequestCommand<T> request);

  /// The callback function to trigger when a log is received from this
  /// network invoker.
  OnNetworkLog get onLog;
}
