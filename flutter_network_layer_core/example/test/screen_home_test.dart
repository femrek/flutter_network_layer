import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ScreenHome has a placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // wait for the network manager to initialize
    await tester.pumpAndSettle();

    // Verify that the returned message from network manager is displayed
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}
