import 'package:example/product/network/app_network_initializer.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:get_it/get_it.dart';

/// The GetIt initializer
class AppGetIt {
  /// Initialize the dependencies for the app.
  static void init() {
    GetIt.I.registerLazySingleton<INetworkInvoker>(
        AppNetworkInitializer.createNetworkInvoker);
  }
}
