import 'dart:async';

import 'package:example_flutter_dio/init/app_get_it.dart';
import 'package:example_flutter_dio/logger/app_logger.dart';
import 'package:example_flutter_dio/logger/i_logger.dart';
import 'package:example_flutter_dio/network/app_network_initializer.dart';
import 'package:flutter/material.dart';

/// The app initializer.
///
/// Initialize the app before it starts.
abstract final class AppInit {
  /// The logger for the app.
  static late final ILogger logger;

  /// Initialize the app.
  ///
  /// Run this function before the app starts.
  static Future<void> init() async {
    logger = AppLogger();
    logger.t('AppInit.init() started');

    WidgetsFlutterBinding.ensureInitialized();
    AppGetIt.init(logger);

    await runZonedGuarded(
      () async {
        logger.t('AppInit.init().runZonedGuarded() started');
        await _init();
        logger.t('AppInit.init().runZonedGuarded() completed');
      },
      (e, s) {
        logger.e('AppInit.init() failed', error: e, stackTrace: s);
      },
    );

    logger.t('AppInit.init() completed');
  }

  static Future<void> _init() async {
    logger.t('AppInit._init() started');

    await AppNetworkInitializer.initNetworkInvoker();

    logger.t('AppInit._init() completed');
  }
}
