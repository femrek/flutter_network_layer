import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// The callback for the progress of the request. Can be used to trace uploading
/// or downloading data.
typedef OnProgressCallback = void Function(int done, int total);

/// The interface to perform a request.
///
/// The interface provides the necessary information about the request such as
/// the path, method, payload type, payload data, headers, progress callbacks,
/// etc.
abstract interface class IRequestCommand<T extends ResponseModel> {
  /// The path of the request.
  String get path;

  /// The method of the request. GET, POST, PUT, DELETE, etc.
  HttpRequestMethod get method;

  /// The type of the payload. Json, form data, etc.
  RequestPayloadType get payloadType;

  /// The payload data of the request. Applicable in the form of Json or form
  /// data.
  Map<String, dynamic> get data;

  /// The headers of the request.
  Map<String, dynamic> get headers;

  /// The callback for the progress of the request.
  OnProgressCallback? get onSendProgressUpdate;

  /// The callback for the progress of the response.
  OnProgressCallback? get onReceiveProgressUpdate;

  /// The sample model to deserialize the response via its fromJson function.
  T get sampleModel;
}
