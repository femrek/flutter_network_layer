import 'package:network/src/core/request/i_request_command.dart';
import 'package:network/src/core/response/i_response_model.dart';
import 'package:network/src/core/response/response_result.dart';

/// The interface to manage and perform the network requests.
// ignore: one_member_abstracts
abstract interface class INetworkManager {
  /// Initialize the network manager. Have to be overridden by the
  /// implementation for async initialization.
  Future<void> init(String baseUrl);

  /// Performs a request and returns the response.
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request);
}
