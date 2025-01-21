import 'dart:convert';
import 'dart:io';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// A network invoker that uses Dart's built-in `HttpClient` to send requests.
class DartNetworkInvoker implements INetworkInvoker {
  /// Create a new instance of [DartNetworkInvoker].
  ///
  /// [onLog] is a callback function to trigger when a log is received from
  /// this network manager.
  DartNetworkInvoker({OnNetworkLog? onLog}) {
    this.onLog = onLog ?? (_) {};
  }

  late final String _baseUrl;
  late final HttpClient _client;

  @override
  late final OnNetworkLog onLog;

  @override
  Future<void> init(String baseUrl) async {
    onLog(NetworkLogTrace.start(message: 'baseUrl: $baseUrl'));

    _baseUrl = baseUrl;
    _client = HttpClient();

    onLog(NetworkLogInit(baseUrl: baseUrl));
    onLog(NetworkLogTrace.end(message: 'baseUrl: $baseUrl'));
  }

  @override
  Future<ResponseResult<T>> request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    onLog(NetworkLogTrace.start(
      message: '${request.method.value} ${request.path}',
    ));
    onLog(NetworkLogRequest(request: request));

    late final ResponseResult<T> result;
    try {
      result = await _request(request);
    } on Exception catch (e, s) {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Unexpected error occurred',
          stackTrace: s,
          error: e,
        ),
      ));
      return ErrorResponseResult.noResponse(
        message: 'Unexpected error occurred',
      );
    }

    result.when(
      success: (result) {
        onLog(NetworkLogSuccessResponse(
          statusCode: result.statusCode,
          data: result.data,
        ));
      },
      error: (_) {},
    );

    onLog(NetworkLogTrace.end(
      message: '${request.method.value} ${request.path}',
    ));

    return result;
  }

  Future<ResponseResult<T>> _request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    final url = '$_baseUrl${request.path}';

    // send request
    late final HttpClientResponse rawResponse;
    try {
      rawResponse = await _sendRequest(url);
    } on SocketException catch (e, s) {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: e.message,
          stackTrace: s,
        ),
      ));
      return ErrorResponseResult.noResponse(
        message: e.message,
      );
    }

    // extract response body
    late final String responseBody;
    try {
      responseBody = await _extractResponseBody(rawResponse);
    } on Exception catch (e, s) {
      onLog(NetworkLogInternalError(
        error: NetworkErrorInvalidResponseType(
          message: 'decode error',
          stackTrace: s,
          error: e,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: e.toString(),
        statusCode: rawResponse.statusCode,
      );
    }

    // check if the response is successful
    if (rawResponse.statusCode < 200 || rawResponse.statusCode >= 300) {
      onLog(NetworkLogErrorResponse(
        error: NetworkErrorResponse(
          statusCode: rawResponse.statusCode,
          message: responseBody,
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Request failed: $responseBody',
        statusCode: rawResponse.statusCode,
      );
    }

    // parse response
    final sampleModel = request.sampleModel;
    late final dynamic responseModelDynamic;
    if (sampleModel is JsonResponseModel) {
      try {
        final responseBodyEncoded = jsonDecode(responseBody);
        responseModelDynamic = sampleModel.fromJson(responseBodyEncoded);
      } on FormatException catch (e, s) {
        onLog(NetworkLogInternalError(
          error: NetworkError(
            message: e.message,
            stackTrace: s,
          ),
        ));
        return ErrorResponseResult.withResponse(
          message: 'Failed to parse response: $responseBody',
          statusCode: rawResponse.statusCode,
        );
      }
    } else if (sampleModel is CustomResponseModel) {
      responseModelDynamic = sampleModel.fromString(responseBody);
    } else {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Undefined sample model of request',
          stackTrace: StackTrace.current,
        ),
      ));
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
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Invalid response model',
          stackTrace: StackTrace.current,
        ),
      ));
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
