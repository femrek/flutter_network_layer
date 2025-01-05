# flutter_network_layer_core The Core Package Of The flutter_network_layer.

Provides the frame for following implementations:

- [flutter_network_layer_dio](https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_dio)

## Usage

Recommended to use with above implementations. However, you can implement your own network layer.

- Create a `INetworkInvoker` implementation like that. This is already implemented in mentioned implementation packages.

```dart
// Network Invoker Implementation

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class NetworkInvoker implements INetworkInvoker {
  @override
  Future<void> init(String baseUrl) async {
    // Create your network client here.
  }

  @override
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
    // Process your request with the network client.
  }
}
```

- Create your own response models like that. These models are specific to api response so they need to be implemented
  in product level.

```dart
import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class ResponseExample implements IResponseModel {
  final String id;
  final String name;
  final int age;

  const ResponseExample({
    required this.id,
    required this.name,
    required this.age,
  });

  const ResponseExample.empty()
      : id = '',
        name = '',
        age = 0;

  @override
  factory ResponseExample.fromJson(Map<String, dynamic> map) {
    return ResponseExample(
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
```

- Create your own request models like that. These models are specific to api request so they need to be implemented
  in product level.

```dart
import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class RequestUser implements IRequestCommand<ResponseUser> {
  @override
  Map<String, dynamic> get data => const {};

  @override
  Map<String, dynamic> get headers => const {};

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  OnProgressCallback? onReceiveProgressUpdate;

  @override
  OnProgressCallback? onSendProgressUpdate;

  @override
  String get path => '/example';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseExample get sampleModel => const ResponseExample.empty();
}
```
