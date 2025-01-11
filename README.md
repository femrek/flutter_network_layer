# flutter_network_layer

A package to use as a network layer for Flutter projects.

To use in your flutter/dart project:

- [flutter_network_layer_dio](https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_dio)
([pub.dev](https://pub.dev/packages/flutter_network_layer_dio))

Or, implement your own with [flutter_network_layer_core](https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_core)
([pub.dev](https://pub.dev/packages/flutter_network_layer_core))

## Table of Contents

- [General Information](#general-information)
    - [Command Pattern Like Request Management](#command-pattern-like-request-management)
    - [Implementation with Dio](#implementation-with-dio)
- [Features](#features)
- [Use in Your Project](#use-in-your-project)

## General Information

A modular architecture template for Flutter projects with a network layer. This template is designed to provide a
network module that can be imported into any Flutter project uses an api.

<img width="1266" alt="Screenshot 2025-01-11 at 02 58 01" src="https://github.com/user-attachments/assets/1c10872a-8c3d-4fb5-9d26-221ccac74c85" />
Figure: Class diagram of flutter_network_layer_core and flutter_network_layer_dio with an example flutter application (Production section in the figure).

### Command Pattern Like Request Management

This package uses an architecture that is similar to the command pattern to manage requests.

Each request is a command that can be executed as a parameter of the `request` method of the `INetworkInvoker`
interface.

Request commands can be created by implementing the `RequestCommand` abstract class. The `RequestCommand` class has
fields that describes the request such as http request method (GET, POST, etc.), request header, payload, etc. The
request is sent to the server by executing the `request` method of the `INetworkInvoker`.

### Implementation with Dio

[flutter_network_layer_dio](https://pub.dev/packages/flutter_network_layer_dio) is the implementation of this
package with dio. For now, there is only this implementation.

## Features

- Modular and easily pluggable architecture.
- Command-pattern-like request management.
- Easy integration with dependency injection frameworks like `get_it`.

## Use in Your Project

Check out the 
[Dio implementation](https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_dio#use-in-your-project)
to see how to use it on your project.

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
