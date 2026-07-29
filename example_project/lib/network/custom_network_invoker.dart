import 'package:dart_network_layer_dio/dart_network_layer_dio.dart';
import 'package:dio/dio.dart';
import 'package:remote_logging/remote_logging.dart';

/// A custom network invoker that extends the [DioNetworkInvoker] and can be
/// used to add custom functionality or configuration to the network invoker.
class CustomNetworkInvoker extends DioNetworkInvoker
    with LoggerMixin<CustomNetworkInvoker> {
  /// Creates an instance of [CustomNetworkInvoker] with the given [Dio]
  /// instance. You can customize the [Dio] instance before passing it to the
  /// super constructor.
  CustomNetworkInvoker(Dio dio)
    : super(
        dio: dio,
        networkLoggerStrategy: DefaultNetworkLogger(
          includeHeaderValuesOfRequest: true,
          includePayloadOfRequest: true,
          includeQueryParameterValuesOfRequest: true,
        ),
      );

  @override
  Future<NetworkResult<T>> send<T extends Schema>(
    RequestCommand<T> request,
  ) async {
    log.info(
      'Making a request: '
      ' ${request.method} ${request.path}',
    );
    return super.send(request);
  }
}
