# Flutter Network Layer

A package set to use as a network layer for Flutter projects.

## Getting Started

Each implementation has its own instructions. Go one of the following implementation see readme. (There is only one
implementation for now)

To use in your Dart/Flutter project follow one of these:

- [flutter_network_layer_dio][gh_flutter_network_layer_dio] ([pub.dev][pd_flutter_network_layer_dio])

Or, implement your own
with [flutter_network_layer_core][gh_flutter_network_layer_core] ([pub.dev][pd_flutter_network_layer_core]).

## Tree of the Project

- The core package is a dependency for the implementations.
- The flutter_network_layer combines all implementations, but its usage is not recommended. (Use a specific
  implementation instead.)

```plaintext
            flutter_network_layer_core
                   /           \
flutter_network_layer_dio   (other implementations...)          flutter_network_layer
            \____________________________\________________________________|
```

## Examples

- [Flutter example with Dio implementation][gh_example_flutter_dio] is an example Flutter project that shows how to
  use `flutter_network_layer_dio` in a Flutter project.

## Example Class Diagram

<img width="1266" alt="Screenshot 2025-01-11 at 02 58 01" src="https://github.com/user-attachments/assets/1c10872a-8c3d-4fb5-9d26-221ccac74c85" />

Figure: Class diagram of an example flutter application (Production section in the figure) with
flutter_network_layer_core and flutter_network_layer_dio.

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

[gh_flutter_network_layer_core]: https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_core

[pd_flutter_network_layer_core]: https://pub.dev/packages/flutter_network_layer_core

[gh_flutter_network_layer_dio]: https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer_dio

[pd_flutter_network_layer_dio]: https://pub.dev/packages/flutter_network_layer_dio

[gh_flutter_network_layer]: https://github.com/femrek/flutter_network_layer/tree/main/flutter_network_layer

[pd_flutter_network_layer]: https://pub.dev/packages/flutter_network_layer

[gh_example_flutter_dio]: https://github.com/femrek/flutter_network_layer/tree/main/example_flutter_dio



