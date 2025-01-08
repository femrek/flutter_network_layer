# flutter_network_layer_dio The Implementation of flutter_network_layer_core with Dio.

Provides the implementation of the network layer with
[Dio](https://pub.dev/packages/dio) package. Includes the network invoker that is defined in
[flutter_network_layer_core.](https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_core)

## Table of Contents

- [General Information](#general-information)
    - [Command Pattern Like Request Management](#command-pattern-like-request-management)
    - [Implementation with Dio](#implementation-with-dio)
- [Features](#features)
- [Use in Your Project](#use-in-your-project)
- [Listen the Logs of the Package](#listen-the-logs-of-the-package)
- [Dio Interceptors](#dio-interceptors)
- [License](#license)

## General Information

A modular architecture template for Flutter projects with a network layer. This template is designed to provide a
network module that can be imported into any Flutter project uses an api.

### Command Pattern Like Request Management

This package uses an architecture that is similar to the command pattern to manage requests.

Each request is a command that can be executed as a parameter of the `request` method of the `INetworkInvoker`
interface.

Request commands can be created by implementing the `RequestCommand` class. The `RequestCommand` class has fields that
describes the request such as http request method (GET, POST, etc.), request header, payload, etc. The request is sent
to the server by executing the `request` method of the `INetworkInvoker`.

### Implementation with Dio

The network layer is implemented with Dio. Another implementation can be used by implementing the `INetworkInvoker`
interface easily.

## Features

- Modular and easily pluggable architecture.
- Command-pattern-like request management.
- Built-in support for Dio.
- Easy integration with dependency injection frameworks like `get_it`.
- Logging trigger function to integrate with logger of the product level.

## Use in Your Project

The tests in the `test` directory demonstrates how to use the network layer. Also, the `example` application is a simple
Flutter application that uses this network layer to fetch data from a server.

- Add the network module as a dependency in the `pubspec.yaml` file of the project.

```yaml
dependencies:
  flutter_network_layer_dio: <version code> # check the version code in the pubspec.yaml file of the module.
```

- Create your own response models like following example. Also, you can use auto generation tools like
  `json_serializable` to generate these models. The only point is that these models should implement the
  `JsonResponseModel` or `CustomResponseModel` and providing valid serialization methods.

```dart
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

final class ResponseUser extends JsonResponseModel {
  const ResponseUser({
    required this.id,
    required this.name,
    required this.age,
  });

  const ResponseUser.empty()
      : id = '',
        name = '',
        age = 0;

  final String id;
  final String name;
  final int age;

  @override
  ResponseUser fromJson(dynamic json) {
    assert(json is Map<String, dynamic>, 'json is not a Map<String, dynamic>');
    final map = json as Map<String, dynamic>;

    return ResponseUser(
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

- Create your own request models (commands) like following example. This class have to include information about the
  request will be sent to the server.

```dart
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

final class RequestUser extends RequestCommand<ResponseUser> {
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
  String get path => '/user';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseUser get sampleModel => const ResponseUser.empty();
}
```

- Use the network layer in your project. Dependency injection is used in the example project, and it is recommended. You
  can use the network layer without dependency injection as well.

```dart
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

import 'request_user.dart';
import 'response_user.dart';

void main() async {
  final INetworkInvoker nm = DioNetworkInvoker();
  final RequestCommand<ResponseUser> request = await nm.request(RequestUser());
  request.when(
    success: (response) {
      print('Response: $response');
    },
    failure: (error) {
      print('Error: $error');
    },
  );
}
```

## Listen the Logs of the Package

The package provides a logging trigger function to integrate with the logger of the product level. The logging trigger
function can be set by calling the `setLoggingTrigger` function of the `NetworkModule` class.

```dart
// pass the logging trigger function when creating the network invoker.
final INetworkInvoker nm = DioNetworkInvoker(
  onLog: _onLog,
);

void _onLog(LogLevel level, String message) {
  // You can use your own logger here.
  // For a simple example, you can print the logs to the console like that.
  print('[$level] $message');

  if (!level.maySensitiveData) {
    // The log message does not contain request or response data for this condition.
  }
}
```

## Dio Interceptors

Dio interceptors can be added to the network invoker by passing them as a parameter to the constructor of the
`DioNetworkInvoker` class. They are added to the Dio instance when the `init` method is called. Check the Dio
documentation for more information about interceptors.

```dart

final INetworkInvoker nm = DioNetworkInvoker(
  dioInterceptors: [
    YourInterceptor(),
  ],
);
```

## License

```
MIT License

Copyright (c) 2025 Faruk Emre

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
