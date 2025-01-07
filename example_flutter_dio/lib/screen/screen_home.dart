import 'package:example_flutter_dio/network/request/request_get_post.dart';
import 'package:example_flutter_dio/network/request/request_get_todo.dart';
import 'package:example_flutter_dio/network/request/request_get_todos.dart';
import 'package:example_flutter_dio/network/request/request_post_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:get_it/get_it.dart';

part '_mixin_home.dart';

/// The home screen of the app.
class ScreenHome extends StatefulWidget {
  /// Creates the home screen.
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with _MixinHome {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _getTodo1,
                child: const Text('get todo 1'),
              ),
              ElevatedButton(
                onPressed: _getTodos,
                child: const Text('get todos'),
              ),
              ElevatedButton(
                onPressed: _getPost1,
                child: const Text('get post 1'),
              ),
              ElevatedButton(
                onPressed: _postAPost,
                child: const Text('post a post'),
              ),
              Text(_data),
            ],
          ),
        ),
      ),
    );
  }
}
