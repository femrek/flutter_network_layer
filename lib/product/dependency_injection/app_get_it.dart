import 'package:flutter_template_network_layer/product/network/app_network_initializer.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';

/// The GetIt initializer
class AppGetIt {
  /// Initialize the dependencies for the app.
  static void init() {
    GetIt.I.registerLazySingleton<INetworkInvoker>(
        AppNetworkInitializer.createNetworkInvoker);
  }
}
