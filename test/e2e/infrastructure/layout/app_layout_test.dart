import 'package:flutter_test/flutter_test.dart';
import 'package:overload/app.dart';
import 'package:overload/infrastructure/pages/home_page.dart';
import 'package:overload/infrastructure/pages/exercises_page.dart';

void main() {
  testWidgets('AppLayout displays the correct page and updates on navigation', (WidgetTester tester) async {
    // Build the AppLayout widget
    await tester.pumpWidget(const App());

    // Verify the initial page is ExercisesPage (since _currentPageIndex is 1)
    expect(find.byType(ExercisesPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
    expect(find.text(ExercisesPage.title), findsAtLeast(1));

    // Tap on the "Home" navigation item
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    // Verify the current page updates to HomePage
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(ExercisesPage), findsNothing);
    expect(find.text(HomePage.title), findsAtLeast(1));
  });
}
