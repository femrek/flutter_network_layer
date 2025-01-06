import 'package:flutter/material.dart';

void main() async {
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
      home: Text('App'),
    );
  }
}
