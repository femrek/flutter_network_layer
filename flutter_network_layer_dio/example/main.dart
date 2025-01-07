import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

void main() async {
  await AppNetworkManager.networkInvoker.init(
    'https://jsonplaceholder.typicode.com',
  );
  final request = RequestUser(id: 1);
  final response = await AppNetworkManager.networkInvoker.request(request);
  response.when(
    success: (response) {
      print('DATA: ${response.data.toString()}');
    },
    error: (response) {
      print('ERROR: ${response.message}');
    },
  );
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
