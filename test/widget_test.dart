import 'package:flutter_test/flutter_test.dart';
import 'package:ds_fun_learning/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DSFunLearningApp());
    expect(find.text('DS Fun Learning'), findsOneWidget);
  });
}
