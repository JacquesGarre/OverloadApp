import 'package:flutter_test/flutter_test.dart';
import 'package:overload/app.dart';
import 'package:overload/infrastructure/pages/home_page.dart';
import 'package:overload/infrastructure/pages/exercises_page.dart';

void main() {
  testWidgets('AppLayout displays the correct page and updates on navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(ExercisesPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
    expect(find.text(ExercisesPage.title), findsAtLeast(1));

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(ExercisesPage), findsNothing);
    expect(find.text(HomePage.title), findsAtLeast(1));
  });
}
