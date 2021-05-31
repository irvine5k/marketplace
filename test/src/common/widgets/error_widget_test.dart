import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/resources/messages.dart';
import 'package:marketplace/src/common/widgets/error_widget.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

void main() {
  testWidgets(
    'When tap at button '
    'shoud call the callback',
    (tester) async {
      var clicked = false;

      await _createWidget(
        tester,
        onRetry: () {
          clicked = true;
        },
      );

      await tester.tap(find.byType(RoundedButtonWidget));

      expect(find.text(AppMessages.somethingWrong), findsOneWidget);

      expect(clicked, true);
    },
  );
}

Future<void> _createWidget(
  WidgetTester tester, {
  required VoidCallback onRetry,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CustomErrorWidget(
          onRetry: onRetry,
        ),
      ),
    ),
  );
}
