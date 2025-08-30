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

    onLog(NetworkLogConfig(baseUrl: baseUrl));
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
      error: (response) {
        final error = response.error;
        onLog(NetworkLogError(error: error));
      },
    );

    onLog(NetworkLogTrace.end(
      message: '${request.method.value} ${request.path}',
    ));

    return result;
  }

  Future<ResponseResult<T>> _request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    final requestPayload = request.payload;

    final Response<dynamic> response;
    final Object? payload;

    switch (request.payloadType) {
      case RequestPayloadType.formData:
        if (requestPayload != null) {
          payload = null;
        } else if (requestPayload is Map<String, dynamic>) {
          payload = FormData.fromMap(requestPayload);
        } else {
          return ErrorResponseResult.noResponse(
            error: NetworkErrorInvalidPayload(
              message:
                  'Invalid payload type. Payload must be Map<String, dynamic> '
                  'when payloadType is RequestPayloadType.formData.',
              stackTrace: StackTrace.current,
            ),
          );
        }
      case RequestPayloadType.other:
        payload = requestPayload;
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
        onLog(NetworkLogError(
          error: NetworkError(
            message: 'No response',
            stackTrace: s,
            error: e,
          ),
        ));
        return ErrorResponseResult.noResponse(
          error: NetworkError(
            message: 'Request failed: $e',
            error: e,
            stackTrace: s,
          ),
        );
      }

      // if the response status code is null, return an internal error.
      final statusCode = response.statusCode;
      if (statusCode == null) {
        return ErrorResponseResult.noResponse(
          error: NetworkError(
            message: 'No status code in response',
            error: e,
            stackTrace: s,
          ),
        );
      }

      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkErrorResponse(
          statusCode: statusCode,
          message: response.data.toString(),
          stackTrace: s,
        ),
      );
    } on Exception catch (e, s) {
      return ErrorResponseResult.noResponse(
        error: NetworkError(
          message: 'Request failed',
          error: e,
          stackTrace: s,
        ),
      );
    }

    final responseData = response.data;
    final statusCode = response.statusCode;

    // return error if the response has no status code or data
    if (statusCode == null) {
      return ErrorResponseResult.noResponse(
        error: NetworkError(
          message: 'Response status code is null',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (responseData == null) {
      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkError(
          message: 'Response data is null',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (responseData is! String) {
      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkErrorInvalidResponseType(
          message: 'Invalid response type. Response data is not String. '
              'Response type: ${responseData.runtimeType} '
              'Response: [$statusCode] $responseData',
          stackTrace: StackTrace.current,
        ),
      );
    }
    if (statusCode < 200 || statusCode >= 300) {
      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkErrorResponse(
          statusCode: statusCode,
          message: 'Response status is not successful. '
              'Response type: ${responseData.runtimeType} '
              'Response status code: $statusCode',
          stackTrace: StackTrace.current,
        ),
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
        return ErrorResponseResult.withResponse(
          statusCode: statusCode,
          error: NetworkErrorInvalidResponseType(
            message: 'Failed to parse response',
            error: e,
            stackTrace: s,
          ),
        );
      }
    } else if (sampleModel is CustomResponseModel) {
      dataDynamic = sampleModel.fromString(responseData);
    } else {
      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkErrorInvalidResponseType(
          message: 'Invalid response model type: ${sampleModel.runtimeType}',
          stackTrace: StackTrace.current,
        ),
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
      return ErrorResponseResult.withResponse(
        statusCode: statusCode,
        error: NetworkErrorInvalidResponseType(
          message: 'Failed to cast response',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }
}
