# flutter_network_layer

A package to use as a network layer for Flutter projects.

## Table of Contents

- [General Information](#general-information)
    - [Command Pattern Like Request Management](#command-pattern-like-request-management)
    - [Implementation with Dio](#implementation-with-dio)
- [Features](#features)
- [Use in Your Project](#use-in-your-project)
    - [Importing the Network Module](#importing-the-network-module)

## General Information

A modular architecture template for Flutter projects with a network layer. This template is designed to provide a
network module that can be imported into any Flutter project uses an api.

### Command Pattern Like Request Management

This package uses an architecture that is similar to the command pattern to manage requests.

Each request is a command that can be executed as a parameter of the `request` method of the `INetworkInvoker`
interface.

Request commands can be created by implementing the `IRequestCommand` interface. The `IRequestCommand` interface has
fields that describes the request such as http request method (GET, POST, etc.), request header, payload, etc. The
request is sent to the server by executing the `request` method of the `INetworkInvoker`.

### Implementation with Dio

The network layer is implemented with Dio. Another implementation can be used by implementing the `INetworkInvoker`
interface easily.

## Features

- Modular and easily pluggable architecture.
- Command-pattern-like request management.
- Built-in support for Dio.
- Easy integration with dependency injection frameworks like `get_it`.

## Use in Your Project

### Importing the Network Module

The tests in the `test` directory demonstrates how to use the network layer. Also, the `example` application is a simple
Flutter application that uses this network layer to fetch data from a server.

`example` project also uses `get_it` implementation to show the efficient usage of the network layer.

- Add the network module as a dependency in the `pubspec.yaml` file of the project.

```yaml
dependencies:
  flutter_network_layer: <version> # check the version code on pub.dev.
```

- Create your own response models like that:

```dart
import 'package:flutter_network_layer/network_module.dart';

final class ResponseUser implements IResponseModel {
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

- Create your own request models like that:

```dart
import 'package:flutter_network_layer/network_module.dart';

final class RequestUser implements IRequestCommand<ResponseUser> {
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

- Use the network layer in your project.

```dart
import 'package:flutter_network_layer/network_module.dart';

import 'request_user.dart';
import 'response_user.dart';

void main() async {
  final INetworkInvoker nm = DioNetworkInvoker();
  final IRequestCommand<ResponseUser> request = await nm.request(RequestUser());
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
