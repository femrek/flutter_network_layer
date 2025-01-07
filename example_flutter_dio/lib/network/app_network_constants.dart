// ignore_for_file: public_member_api_docs constant class

/// The class contains the network constants for the app.
abstract final class AppNetworkConstants {
  /// The base URL for the network requests.
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const String posts = '/posts';
  static const String todos = '/todos';

  static String postById(Object id) => '$posts/$id';
  static String todoById(Object id) => '$todos/$id';
}
