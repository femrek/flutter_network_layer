import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:network/network.dart';

/// The network manager class for managing to api communication.
final class DioNetworkManager implements INetworkManager {
  /// Create a new instance of [DioNetworkManager].
  ///
  /// [onDioLog] is a callback function to trigger when a log is received from
  /// this network manager.
  DioNetworkManager({
    OnDioLog? onDioLog,
  }) {
    this.onDioLog = onDioLog ??= (_, __) {};
  }

  /// The callback function to trigger when a log is received from this
  /// network manager.
  late final OnDioLog onDioLog;

  /// defined as a late variable to be initialized in the [init] function.
  late final Dio _dio;

  static const String _tag = 'DioNetworkManager';

  @override
  Future<void> init(
    String baseUrl, {
    LogInterceptor? logInterceptor,
  }) async {
    onDioLog(
      LogLevel.trace,
      'START: $_tag.init: $baseUrl',
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        responseType: ResponseType.plain,
      ),
    );

    if (logInterceptor != null) {
      _dio.interceptors.add(logInterceptor);
    }

    onDioLog(
      LogLevel.init,
      '$_tag initialized with baseUrl: $baseUrl',
    );
    onDioLog(
      LogLevel.trace,
      'END  : $_tag.init: $baseUrl',
    );
  }

  @override
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
    onDioLog(
      LogLevel.trace,
      'START: $_tag.request: ${request.method.value} ${request.path}',
    );

    final result = await _request(request);

    result.when(
      success: (response) {
        onDioLog(
          LogLevel.successResponse,
          'Response: ${response.statusCode} ${response.data.toJson()}',
        );
      },
      error: (response) {
        onDioLog(
          LogLevel.errorResponse,
          'Response: ${response.statusCode} ${response.message}',
        );
      },
    );

    onDioLog(
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

    onDioLog(
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
    } on Exception catch (e, s) {
      onDioLog(
        LogLevel.internalError,
        'Request failed exception: $e $s',
      );
      return ErrorResponseResult.noResponse(
        message: 'Request failed: $e',
      );
    }

    final responseData = response.data;
    final statusCode = response.statusCode;

    if (statusCode == null) {
      onDioLog(
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
      onDioLog(
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
      onDioLog(
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
