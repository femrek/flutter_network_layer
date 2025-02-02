import 'package:example/product/network/request/request_get_post.dart';
import 'package:example/product/network/request/request_get_todo.dart';
import 'package:example/product/network/request/request_get_todos.dart';
import 'package:example/product/network/request/request_post_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:get_it/get_it.dart';

/// The home screen.
class ScreenHome extends StatefulWidget {
  /// Create an instance of [ScreenHome].
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Future<void> _getTodo1() async {
    final response =
        await GetIt.I<INetworkInvoker>().request(RequestGetTodo(id: 1));
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get todo 1';
        });
      },
    );
  }

  Future<void> _getTodos() async {
    final response =
        await GetIt.I<INetworkInvoker>().request(RequestGetTodos());
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get todos';
        });
      },
    );
  }

  Future<void> _getPost1() async {
    final response =
        await GetIt.I<INetworkInvoker>().request(RequestGetPost(id: 1));
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get post 1';
        });
      },
    );
  }

  Future<void> _postAPost() async {
    final response = await GetIt.I<INetworkInvoker>().request(
      RequestPostPost(
        userId: 1,
        title: 'foo',
        body: 'bar',
      ),
    );
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to post a post';
        });
      },
    );
  }

  String _data = '';

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
