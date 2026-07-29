import 'dart:async';
import 'dart:ui';

import 'package:example_project/network/app_repos.dart';
import 'package:example_project/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:remote_logging/remote_logging.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      // logging
      RemoteLogging.initLocalOnly(
        config: const RemoteLoggingConfig(
          enableRemoteLogging: false,
        ),
      );
      FlutterError.onError = (errorDetails) {
        FlutterError.presentError(errorDetails);
        logger('main').severe(
          'unhandled error:',
          errorDetails.exception,
          errorDetails.stack,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        logger('main').severe('unhandled error:', error, stack);
        return true;
      };

      final appRepos = AppRepos();

      runApp(App(repos: appRepos));
    },
    (error, stackTrace) {
      logger('main').severe('unhandled error:', error, stackTrace);
    },
    zoneValues: {'name': 'main'},
  );
}

/// The root of the application
class App extends StatelessWidget {
  /// create the root of the application with dependencies.
  const App({
    required this.repos,
    super.key,
  });

  /// The bundle of all api clients.
  final AppRepos repos;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Layer Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: DashboardPage(
        apiClient: repos.example,
      ),
    );
  }
}
