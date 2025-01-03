/// Interface for responses from the server.
abstract interface class IResponseModel {
  /// Converts the instance to a map.
  dynamic toJson();

  /// Converts the map to an instance.
  IResponseModel fromJson(dynamic json);
}
