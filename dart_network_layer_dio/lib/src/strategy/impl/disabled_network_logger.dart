import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:dart_network_layer_dio/src/strategy/network_logger_strategy.dart';

/// An alternative implementation of [NetworkLoggerStrategy] that disables
/// logging by providing empty implementations for all logging methods.
class DisabledNetworkLogger implements NetworkLoggerStrategy {
  /// Creates a [DisabledNetworkLogger] instance.
  const DisabledNetworkLogger();

  @override
  void logRequest<T extends Schema>(RequestCommand<T> request) {}

  @override
  void logSuccess<T extends Schema>(
      RequestCommand<T> request, SpecifiedResponseResult<T> result) {}

  @override
  void logUnsuccessful<T extends Schema>(
      RequestCommand<T> request, SpecifiedResponseResult<T> result) {}

  @override
  void logError<T extends Schema>(
      RequestCommand<T> request, NetworkErrorResult<T> result) {}
}
