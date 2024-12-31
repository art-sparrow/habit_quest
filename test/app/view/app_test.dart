import 'package:flutter_test/flutter_test.dart';
import 'package:habit_quest/app/view/app.dart';

void main() {
  group('App', () {
    testWidgets('renders App successfully', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(App), findsOneWidget);
    });
  });
}
