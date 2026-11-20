import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eyeflow/main.dart';

Future<void> openHome(WidgetTester tester) async {
  await tester.pumpWidget(const EyeFlowApp());
  await tester.tap(find.text('CONTINUE'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Continue on the login page opens the home dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EyeFlowApp());

    expect(find.text('SIGN IN'), findsOneWidget);
    expect(find.text('HOME DASHBOARD'), findsNothing);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    expect(find.text('SIGN IN'), findsNothing);
    expect(find.text('HOME DASHBOARD'), findsOneWidget);
  });

  testWidgets('Home dashboard shows login placeholder and module buttons', (
    WidgetTester tester,
  ) async {
    await openHome(tester);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText && widget.text.toPlainText() == 'EYE FLOW',
      ),
      findsOneWidget,
    );
    expect(find.text('HOME DASHBOARD'), findsOneWidget);
    expect(find.text('Select any button'), findsOneWidget);
    expect(find.text('S'), findsOneWidget);

    expect(find.text('INVENTORY MANAGEMENT'), findsOneWidget);
    expect(find.text('PRODUCTION TRACKING'), findsOneWidget);
    expect(find.text('VERIFICATION & BATCH TRACKING'), findsOneWidget);
    expect(find.text('REPORT, COSTING & AI ASSISTANT'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Login placeholder'));
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsOneWidget);
    expect(
      find.text('Login is a placeholder. Nothing is saved or checked.'),
      findsOneWidget,
    );
  });

  testWidgets('Module buttons open an empty page and back returns home', (
    WidgetTester tester,
  ) async {
    await openHome(tester);

    const titles = [
      'INVENTORY MANAGEMENT',
      'PRODUCTION TRACKING',
      'VERIFICATION & BATCH TRACKING',
      'REPORT, COSTING & AI ASSISTANT',
    ];

    for (final title in titles) {
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();

      expect(find.text('HOME DASHBOARD'), findsNothing);
      expect(find.text(title), findsOneWidget);
      expect(find.byTooltip('Back'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('HOME DASHBOARD'), findsOneWidget);
    }
  });
}
