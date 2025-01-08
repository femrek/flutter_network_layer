// ignore_for_file: avoid_print just an example

import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

void main() async {
  await AppNetworkManager.networkInvoker.init(
    'https://jsonplaceholder.typicode.com',
  );
  final request = RequestUser(id: 1);
  final response = await AppNetworkManager.networkInvoker.request(request);
  response.when(
    success: (response) {
      print('DATA: ${response.data}');
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

final class ResponseUser extends JsonResponseModel {
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

final class RequestUser extends RequestCommand<ResponseUser> {
  RequestUser({
    required this.id,
  });

  final int id;

  @override
  String get path => '/users/$id';

  @override
  ResponseUser get sampleModel => const ResponseUser.empty();
}
