import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';
import 'package:flutter_network_layer_core/src/response/ignored_response_model.dart';

import 'test_response_samples.dart';

final class RequestTest1
    extends RequestCommand<ResponseTest1, IgnoredResponseModel> {
  RequestTest1({
    required this.field1,
  });

  final String field1;

  @override
  Map<String, dynamic> get payload => {
        'field1': field1,
      };

  @override
  String get path => '/basic_test';

  @override
  final ResponseTest1Factory responseFactory = ResponseTest1Factory();

  @override
  final ResponseFactory<IgnoredResponseModel> errorResponseFactory =
      IgnoredResponseModelFactory();
}

final class RequestTest1Error
    extends RequestCommand<ResponseTest1, ResponseTestError> {
  RequestTest1Error({
    required this.field1,
  });

  final String field1;

  @override
  Map<String, dynamic> get payload => {
        'shouldReturnError': field1,
      };

  @override
  String get path => '/basic_test_error';

  @override
  final ResponseTest1Factory responseFactory = ResponseTest1Factory();

  @override
  final ResponseTestErrorFactory errorResponseFactory =
      ResponseTestErrorFactory();
}
