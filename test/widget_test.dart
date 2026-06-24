import 'package:flutter_test/flutter_test.dart';
import 'package:memorybloom/main.dart';

void main() {
  testWidgets('WelcomeScreen renders app title', (WidgetTester tester) async {
    await tester.pumpWidget(const MemoryBloomApp());
    await tester.pump();
    expect(find.text('MemoryBloom'), findsOneWidget);
  });
}
