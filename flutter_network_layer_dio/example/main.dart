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

  static void _onLog(NetworkLog log) {
    print('[${log.type}] ${log.message}');
  }
}

final class ResponseUser extends ResponseModel {
  const ResponseUser({
    required this.id,
    required this.name,
  });

  const ResponseUser.empty()
      : id = 0,
        name = '';

  final int id;
  final String name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => toJson().toString();
}

final class ResponseUserFactory extends JsonResponseFactory<ResponseUser> {
  factory ResponseUserFactory() => _instance;

  const ResponseUserFactory._internal();

  static const ResponseUserFactory _instance = ResponseUserFactory._internal();

  @override
  ResponseUser fromJson(dynamic json) {
    assert(json is Map<String, dynamic>, 'json is not a Map<String, dynamic>');
    final map = json as Map<String, dynamic>;

    return ResponseUser(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}

final class RequestUser
    extends RequestCommand<ResponseUser, IgnoredResponseModel> {
  RequestUser({
    required this.id,
  });

  final int id;

  @override
  String get path => '/users/$id';

  @override
  final ResponseFactory<ResponseUser> responseFactory = ResponseUserFactory();

  @override
  final ResponseFactory<IgnoredResponseModel> errorResponseFactory =
      IgnoredResponseModelFactory();
}
