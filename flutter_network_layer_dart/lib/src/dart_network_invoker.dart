import 'dart:convert';
import 'dart:io';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// A network invoker that uses Dart's built-in `HttpClient` to send requests.
class DartNetworkInvoker implements INetworkInvoker {
  late final String _baseUrl;
  late final HttpClient _client;

  @override
  Future<void> init(String baseUrl) async {
    _baseUrl = baseUrl;
    _client = HttpClient();
  }

  @override
  Future<ResponseResult<T>> request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    final url = '$_baseUrl${request.path}';

    // request
    final rawResponse = await _sendRequest(url);
    final responseBody = await _extractResponseBody(rawResponse);
    if (rawResponse.statusCode < 200 || rawResponse.statusCode >= 300) {
      return ErrorResponseResult.withResponse(
        message: 'Request failed: $responseBody',
        statusCode: rawResponse.statusCode,
      );
    }

    // parse response
    final sampleModel = request.sampleModel;
    late final dynamic responseModelDynamic;
    if (sampleModel is JsonResponseModel) {
      final responseBodyEncoded = jsonDecode(responseBody);
      responseModelDynamic = sampleModel.fromJson(responseBodyEncoded);
    } else if (sampleModel is CustomResponseModel) {
      responseModelDynamic = sampleModel.fromString(responseBody);
    } else {
      return ErrorResponseResult.withResponse(
        message: 'Undefined sample model of request: $request',
        statusCode: rawResponse.statusCode,
      );
    }

    // validate the parsing process
    late final T responseModel;
    if (responseModelDynamic is T) {
      responseModel = responseModelDynamic;
    } else {
      return ErrorResponseResult.withResponse(
        message: 'Invalid response model',
        statusCode: rawResponse.statusCode,
      );
    }

    // return the response
    return SuccessResponseResult<T>(
      data: responseModel,
      statusCode: 200,
    );
  }

  Future<HttpClientResponse> _sendRequest(String url) async {
    final request = await _client.getUrl(Uri.parse(url));
    return request.close();
  }

  Future<String> _extractResponseBody(HttpClientResponse response) async {
    final responseStream = await response.toList();
    final responseBytes = responseStream.expand<int>((e) => e).toList();
    final responseBody = String.fromCharCodes(responseBytes);
    return responseBody;
  }
}
