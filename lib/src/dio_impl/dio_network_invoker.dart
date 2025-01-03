import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The network manager class for managing to api communication.
final class DioNetworkInvoker implements INetworkInvoker {
  /// Create a new instance of [DioNetworkInvoker].
  ///
  /// [onLog] is a callback function to trigger when a log is received from
  /// this network manager.
  DioNetworkInvoker({
    OnDioInvokerLog? onLog,
    this.dioInterceptors = const [],
  }) {
    this.onLog = onLog ??= (_, __) {};
  }

  /// The callback function to trigger when a log is received from this
  /// network manager.
  late final OnDioInvokerLog onLog;

  /// Middleware tool provided by [Dio] to execute code before and after
  /// the request.
  ///
  /// They are added to the [Dio] instance when the [init] function is called.
  /// See also [LogInterceptor] that is a built-in interceptor to log the
  /// request and response data or errors.
  final List<Interceptor> dioInterceptors;

  /// defined as a late variable to be initialized in the [init] function.
  late final Dio _dio;

  static const String _tag = 'DioNetworkManager';

  @override
  Future<void> init(String baseUrl) async {
    onLog(
      LogLevel.trace,
      'START: $_tag.init: $baseUrl',
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.plain,
      ),
    );

    for (final interceptor in dioInterceptors) {
      _dio.interceptors.add(interceptor);
    }

    onLog(
      LogLevel.init,
      '$_tag initialized with baseUrl: $baseUrl',
    );
    onLog(
      LogLevel.trace,
      'END  : $_tag.init: $baseUrl',
    );
  }

  @override
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
    onLog(
      LogLevel.trace,
      'START: $_tag.request: ${request.method.value} ${request.path}',
    );

    final result = await _request(request);

    result.when(
      success: (response) {
        onLog(
          LogLevel.successResponse,
          'Response: ${response.statusCode} ${response.data.toJson()}',
        );
      },
      error: (response) {
        onLog(
          LogLevel.errorResponse,
          'Response: ${response.statusCode} ${response.message}',
        );
      },
    );

    onLog(
      LogLevel.trace,
      'END  : $_tag.request: ${request.method.value} ${request.path}',
    );

    return result;
  }

  Future<ResponseResult<T>> _request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
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

    onLog(
      LogLevel.request,
      'Request: ${request.method.value} ${request.path} payload: $payload',
    );

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
        onLog(
          LogLevel.internalError,
          'No response when exception: $e$s',
        );
        return ErrorResponseResult.noResponse(
          message: 'Request failed: $e',
        );
      }

      // if the response status code is null, return an internal error.
      final statusCode = response.statusCode;
      if (statusCode == null) {
        onLog(
          LogLevel.internalError,
          'No status code in response: $e$s',
        );
        return ErrorResponseResult.noResponse(
          message: 'No status code in response: $e',
        );
      }

      return ErrorResponseResult.withResponse(
        message: response.data.toString(),
        statusCode: statusCode,
      );
    } on Exception catch (e, s) {
      onLog(
        LogLevel.internalError,
        'Request failed exception: $e$s',
      );
      return ErrorResponseResult.noResponse(
        message: 'Request failed: $e',
      );
    }

    final responseData = response.data;
    final statusCode = response.statusCode;

    if (statusCode == null) {
      onLog(
        LogLevel.internalError,
        'Status code of received response is null.',
      );
      return ErrorResponseResult.noResponse(
        message: 'Response status code is null',
      );
    }
    if (responseData == null) {
      return ErrorResponseResult.withResponse(
        message: 'Response data is null',
        statusCode: statusCode,
      );
    }
    if (responseData is! String) {
      onLog(
        LogLevel.internalError,
        'Invalid response type. Response data is expected to be String. '
        'Response type: ${responseData.runtimeType}',
      );
      return ErrorResponseResult.withResponse(
        message: 'Invalid response type. Response data is not String. '
            'Response type: ${responseData.runtimeType} '
            'Response: [$statusCode] $responseData',
        statusCode: statusCode,
      );
    }
    if (statusCode < 200 || statusCode >= 300) {
      return ErrorResponseResult.withResponse(
        message: 'Response status is not successful. '
            'Response type: ${responseData.runtimeType} '
            'Response status code: $statusCode '
            'Response: $responseData',
        statusCode: statusCode,
      );
    }

    final json = jsonDecode(responseData);
    final dataDynamic = request.sampleModel.fromJson(json);

    late final T data;
    try {
      data = dataDynamic as T;
      return SuccessResponseResult(
        data: data,
        statusCode: statusCode,
      );
    } on Exception catch (e, s) {
      onLog(
        LogLevel.internalError,
        'Failed to parse response: $e $s',
      );
      return ErrorResponseResult.withResponse(
        message: 'Failed to parse response: $e',
        statusCode: statusCode,
      );
    }
  }
}
