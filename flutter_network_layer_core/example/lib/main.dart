import 'package:flutter/material.dart';
import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

void main() async {
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
      home: ScreenHome(),
    );
  }
}

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final networkManager = NetworkManager();
    networkManager.init('https://example.com');

    final response = await networkManager.request(RequestExample());
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.message;
        });
      },
      error: (response) {
        print('Error: ${response.message}');
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
      body: Center(
        child: Text(_data),
      ),
    );
  }
}

class NetworkManager implements INetworkInvoker {
  @override
  Future<void> init(String baseUrl) async {}

  @override
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
    final dummyResponseJson = <String, dynamic>{'message': 'Hello, World!'};
    final dummyResponse = request.sampleModel.fromJson(dummyResponseJson) as T;
    return SuccessResponseResult(
      statusCode: 200,
      data: dummyResponse,
    );
  }
}

class RequestExample implements IRequestCommand<ResponseExample> {
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
  String get path => '/example';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseExample get sampleModel => const ResponseExample.empty();

  @override
  String toString() {
    return 'RequestExample{path: $path, '
        'method: $method, '
        'payloadType: $payloadType, '
        'data: $data, '
        'headers: $headers, '
        'onSendProgressUpdate: $onSendProgressUpdate, '
        'onReceiveProgressUpdate: $onReceiveProgressUpdate, '
        'sampleModel: $sampleModel}';
  }
}

class ResponseExample implements IResponseModel {
  const ResponseExample({required this.message});

  const ResponseExample.empty() : message = '';

  final String message;

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
      };

  @override
  IResponseModel fromJson(dynamic json) {
    return ResponseExample(message: json['message'] as String);
  }

  @override
  String toString() {
    return 'ResponseExample instance';
  }
}
