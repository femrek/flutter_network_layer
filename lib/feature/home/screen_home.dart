import 'package:flutter/material.dart';
import 'package:flutter_template_network_layer/product/network/request/request_get_todo.dart';
import 'package:flutter_template_network_layer/product/network/request/request_get_todos.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';

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
        await GetIt.I<INetworkManager>().request(const RequestGetTodo(id: 1));
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
        await GetIt.I<INetworkManager>().request(const RequestGetTodos());
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
              Text(_data),
            ],
          ),
        ),
      ),
    );
  }
}
