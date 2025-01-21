import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The network manager class for managing to api communication.
final class DioNetworkInvoker implements INetworkInvoker {
  /// Create a new instance of [DioNetworkInvoker].
  ///
  /// [onLog] is a callback function to trigger when a log is received from
  /// this network manager.
  DioNetworkInvoker({
    OnNetworkLog? onLog,
    this.dioInterceptors = const [],
  }) {
    this.onLog = onLog ??= (_) {};
  }

  @override
  late final OnNetworkLog onLog;

  /// Middleware tool provided by [Dio] to execute code before and after
  /// the request.
  ///
  /// They are added to the [Dio] instance when the [init] function is called.
  /// See also [LogInterceptor] that is a built-in interceptor to log the
  /// request and response data or errors.
  final List<Interceptor> dioInterceptors;

  /// defined as a late variable to be initialized in the [init] function.
  late final Dio _dio;

  @override
  Future<void> init(String baseUrl) async {
    onLog(NetworkLogTrace.start(message: 'baseUrl: $baseUrl'));

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.plain,
      ),
    );

    for (final interceptor in dioInterceptors) {
      _dio.interceptors.add(interceptor);
    }

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

    final result = await _request(request);

    result.when(
      success: (response) {
        onLog(NetworkLogSuccessResponse(
          statusCode: response.statusCode,
          data: response.data,
        ));
      },
      error: (response) {},
    );

    onLog(NetworkLogTrace.end(
      message: '${request.method.value} ${request.path}',
    ));

    return result;
  }

  Future<ResponseResult<T>> _request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    late final Response<dynamic> response;

    final Object? payload;
    if (request.data.isEmpty) {
      payload = null;
    } else {
      switch (request.payloadType) {
        case RequestPayloadType.json:
          payload = request.data;
        case RequestPayloadType.formData:
          payload = FormData.fromMap(request.data);
      }
    }

    // perform request
    try {
      response = await _dio.request<dynamic>(
        request.path,
        data: payload,
        onSendProgress: request.onSendProgressUpdate,
        onReceiveProgress: request.onReceiveProgressUpdate,
        options: Options(
          method: request.method.value,
          headers: request.headers,
        ),
      );
    } on DioException catch (e, s) {
      // if the response is null, return an internal error.
      final response = e.response;
      if (response == null) {
        onLog(NetworkLogInternalError(
          error: NetworkError(
            message: 'No response',
            stackTrace: s,
            error: e,
          ),
        ));
        return ErrorResponseResult.noResponse(
          message: 'Request failed: $e',
        );
      }

      // if the response status code is null, return an internal error.
      final statusCode = response.statusCode;
      if (statusCode == null) {
        onLog(NetworkLogInternalError(
          error: NetworkError(
            message: 'No status code in response',
            stackTrace: s,
            error: e,
          ),
        ));
        return ErrorResponseResult.noResponse(
          message: 'No status code in response: $e',
        );
      }

      onLog(NetworkLogErrorResponse(
        error: NetworkErrorResponse(
          statusCode: statusCode,
          message: response.data.toString(),
          stackTrace: s,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: response.data.toString(),
        statusCode: statusCode,
      );
    } on Exception catch (e, s) {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Request failed',
          stackTrace: s,
          error: e,
        ),
      ));
      return ErrorResponseResult.noResponse(
        message: 'Request failed: $e',
      );
    }

    final responseData = response.data;
    final statusCode = response.statusCode;

    // return error if the response has error
    if (statusCode == null) {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Response status code is null',
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.noResponse(
        message: 'Response status code is null',
      );
    }
    if (responseData == null) {
      onLog(NetworkLogInternalError(
        error: NetworkError(
          message: 'Response data is null',
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Response data is null',
        statusCode: statusCode,
      );
    }
    if (responseData is! String) {
      onLog(NetworkLogInternalError(
        error: NetworkErrorInvalidResponseType(
          message: 'Invalid response type. Response data is not String. '
              'Response type: ${responseData.runtimeType}',
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Invalid response type. Response data is not String. '
            'Response type: ${responseData.runtimeType} '
            'Response: [$statusCode] $responseData',
        statusCode: statusCode,
      );
    }
    if (statusCode < 200 || statusCode >= 300) {
      onLog(NetworkLogErrorResponse(
        error: NetworkErrorResponse(
          statusCode: statusCode,
          message: 'Response(${responseData.runtimeType}): $responseData',
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Response status is not successful. '
            'Response type: ${responseData.runtimeType} '
            'Response status code: $statusCode '
            'Response: $responseData',
        statusCode: statusCode,
      );
    }

    // parse response data
    late final dynamic dataDynamic;
    final sampleModel = request.sampleModel;
    if (sampleModel is JsonResponseModel) {
      try {
        final json = jsonDecode(responseData);
        dataDynamic = sampleModel.fromJson(json);
      } on FormatException catch (e, s) {
        onLog(NetworkLogInternalError(
          error: NetworkErrorInvalidResponseType(
            message: 'Failed to parse response',
            stackTrace: s,
            error: e,
          ),
        ));
        return ErrorResponseResult.withResponse(
          message: 'Failed to parse response: $e',
          statusCode: statusCode,
        );
      }
    } else if (sampleModel is CustomResponseModel) {
      dataDynamic = sampleModel.fromString(responseData);
    } else {
      onLog(NetworkLogInternalError(
        error: NetworkErrorInvalidResponseType(
          message: 'Invalid response model type: ${sampleModel.runtimeType}',
          stackTrace: StackTrace.current,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Invalid response model type: ${sampleModel.runtimeType}',
        statusCode: statusCode,
      );
    }

    // return success response
    late final T data;
    try {
      data = dataDynamic as T;
      return SuccessResponseResult(
        data: data,
        statusCode: statusCode,
      );
    } on Exception catch (e, s) {
      onLog(NetworkLogInternalError(
        error: NetworkErrorInvalidResponseType(
          message: 'Failed to cast response',
          stackTrace: s,
          error: e,
        ),
      ));
      return ErrorResponseResult.withResponse(
        message: 'Failed to parse response: $e',
        statusCode: statusCode,
      );
    }
  }
}
