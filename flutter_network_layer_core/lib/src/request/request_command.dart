import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// The callback for the progress of the request. Can be used to trace uploading
/// or downloading data.
typedef OnProgressCallback = void Function(int done, int total);

/// The interface/class to configure a request type.
///
/// An implementation should provide the necessary information about the request
/// such as the path, method, payload type, payload data, headers, progress
/// callbacks, etc.
abstract class RequestCommand<T extends ResponseModel> {
  /// The path of the request.
  String get path;

  /// The sample model to deserialize the response via its fromJson function.
  T get sampleModel;

  /// The method of the request. GET, POST, PUT, DELETE, etc.
  HttpRequestMethod get method => HttpRequestMethod.get;

  /// The type of the payload. By default it is [RequestPayloadType.other] that
  /// means no special handling is required. If it is
  /// [RequestPayloadType.formData], the [payload] will be sent as form data.
  RequestPayloadType get payloadType => RequestPayloadType.other;

  /// The payload data of the request. Applicable in the form of Json, form data
  /// or string
  Object? get payload => null;

  /// The headers of the request.
  Map<String, dynamic> get headers => const {};

  /// The callback for the progress of the request.
  OnProgressCallback? get onSendProgressUpdate => null;

  /// The callback for the progress of the response.
  OnProgressCallback? get onReceiveProgressUpdate => null;

  /// The log string of the request. Can be overridden to provide a custom log
  /// string.
  ///
  /// The default implementation returns a string that contains the method,
  /// path, payload type, headers, and data.
  ///
  /// The log helper of the package uses this method to log the request data.
  /// So, if you want to customize the log string, you can override this method.
  String toLogString() {
    return '$runtimeType ${method.value} $path '
        'Payload Type: $payloadType '
        'Headers: $headers '
        'Data: $payload';
  }
}
