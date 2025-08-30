/// Defines the type of the payload. JSON, form data, etc.
enum RequestPayloadType {
  /// The payload is in form data format. `Map<String, dynamic>` is allowed.
  formData,

  /// The payload is a plain string, character sequence or binary data, etc.
  ///
  other,
}
