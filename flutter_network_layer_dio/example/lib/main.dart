import 'package:flutter/material.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

void main() async {
  await AppNetworkManager.networkInvoker.init(
    'https://jsonplaceholder.typicode.com',
  );
  runApp(const App());
}

/// The app widget.
class App extends StatelessWidget {
  /// Create an instance of [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _request();
  }

  Future<void> _request() async {
    final request = RequestUser(id: 1);
    final response = await AppNetworkManager.networkInvoker.request(request);
    response.when(
      success: (response) {
        setState(() => _data = response.data.toString());
      },
      error: (response) {
        print('Error: ${response.message}');
        setState(() => _data = 'Failed to get user');
      },
    );
  }

  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_data),
      ),
    );
  }
}

abstract final class AppNetworkManager {
  static final INetworkInvoker networkInvoker =
      DioNetworkInvoker(onLog: _onLog);

  static void _onLog(LogLevel level, String message) {
    print('[${level.name}] $message');
  }
}

final class ResponseUser implements IResponseModel {
  const ResponseUser({
    required this.id,
    required this.name,
  });

  const ResponseUser.empty()
      : id = 0,
        name = '';

  final int id;
  final String name;

  @override
  ResponseUser fromJson(dynamic json) {
    assert(json is Map<String, dynamic>, 'json is not a Map<String, dynamic>');
    final map = json as Map<String, dynamic>;

    return ResponseUser(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => toJson().toString();
}

final class RequestUser implements IRequestCommand<ResponseUser> {
  RequestUser({
    required this.id,
  });

  final int id;

  @override
  Map<String, dynamic> get data => const {};

  @override
  Map<String, dynamic> get headers => const {};

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  OnProgressCallback? onReceiveProgressUpdate;

  @override
  OnProgressCallback? onSendProgressUpdate;

  @override
  String get path => '/users/$id';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseUser get sampleModel => const ResponseUser.empty();
}
