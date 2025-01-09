import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class ResponseTestUser extends JsonResponseModel {
  const ResponseTestUser({
    required this.id,
    required this.name,
    required this.age,
  });

  const ResponseTestUser.empty()
      : id = '',
        name = '',
        age = 0;

  final String id;
  final String name;
  final int age;

  @override
  ResponseTestUser fromJson(dynamic json) {
    assert(json is Map<String, dynamic>, 'json is not a Map<String, dynamic>');
    final map = json as Map<String, dynamic>;

    return ResponseTestUser(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
