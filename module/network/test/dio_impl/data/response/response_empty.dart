import 'package:network/network.dart';

class ResponseEmpty implements IResponseModel {
  const ResponseEmpty();

  @override
  IResponseModel fromJson(dynamic json) => const ResponseEmpty();

  @override
  List<void> toJson() => const [];
}
