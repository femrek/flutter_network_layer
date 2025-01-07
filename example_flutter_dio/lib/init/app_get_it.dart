import 'package:example_flutter_dio/logger/i_logger.dart';
import 'package:example_flutter_dio/network/app_network_initializer.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:get_it/get_it.dart';

/// The GetIt initializer
abstract final class AppGetIt {
  /// Initialize the dependencies for the app.
  static void init(ILogger logger) {
    GetIt.I
      ..registerSingleton<ILogger>(logger)
      ..registerSingleton<INetworkInvoker>(
        AppNetworkInitializer.createNetworkInvoker(),
      );
  }
}
