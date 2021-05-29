import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

final _alertDialogTitle = 'Alert Dialog';

void main() {
  testWidgets(
    'When tap custom dialog button '
    'should execute the callback',
    (tester) async {
      var clicked = false;

      await _createWidget(tester, onPressed: () {
        clicked = true;
      });

      await tester.tap(find.byType(RoundedButtonWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));

      expect(clicked, true);
    },
  );
}

Future<void> _createWidget(
  WidgetTester tester, {
  VoidCallback? onPressed,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: _Widget(
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

class _Widget extends StatelessWidget {
  final VoidCallback? onPressed;

  const _Widget({Key? key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedButtonWidget(
      onTap: () => Utils.showCustomDialog(
        context,
        title: _alertDialogTitle,
        onPressed: onPressed ?? () {},
      ),
      label: 'Button',
    );
  }
}
