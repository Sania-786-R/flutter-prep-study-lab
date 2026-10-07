import 'package:flutter_test/flutter_test.dart';
import 'package:prep_study_lab/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    expect(PrepStudyLabApp, isNotNull);
  });
}
