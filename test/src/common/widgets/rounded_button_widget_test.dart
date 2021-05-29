import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

final _label = 'Label';

void main() {
  testWidgets(
      'When tap at button '
      'shoud call the callback', (tester) async {
    var clicked = false;

    await _createWidget(
      tester,
      onTap: () {
        clicked = true;
      },
    );

    await tester.tap(find.byType(RoundedButtonWidget));

    expect(clicked, true);
  });
  testWidgets(
    'When create the widget '
    'should find the correct widgets',
    (tester) async {
      await _createWidget(
        tester,
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(_label), findsOneWidget);
    },
  );
}

Future<void> _createWidget(
  WidgetTester tester, {
  VoidCallback? onTap,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: RoundedButtonWidget(
          onTap: onTap,
          label: _label,
        ),
      ),
    ),
  );
}
