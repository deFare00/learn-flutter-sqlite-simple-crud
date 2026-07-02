import 'package:flutter_test/flutter_test.dart';

import 'package:student_management/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentManagementApp());
    await tester.pumpAndSettle();

    // Verify the app title is present
    expect(find.text('Student List'), findsOneWidget);
  });
}