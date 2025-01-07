import 'package:example_flutter_dio/init/app_init.dart';
import 'package:example_flutter_dio/screen/screen_home.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInit.init();
  runApp(const App());
}

/// The root of the application
class App extends StatelessWidget {
  /// Creates the application.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ScreenHome(),
    );
  }
}
