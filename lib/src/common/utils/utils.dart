import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

class Utils {
  static String formatToMonetaryValueFromInteger(int value) =>
      NumberFormat.currency(
        locale: 'en-US',
        symbol: '\$',
      ).format(value == 0 ? 0 : value / 100);

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required VoidCallback onPressed,
    String buttonLabel = 'OK',
    String? description,
  }) =>
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xfff5fe88),
          title: Text(
            title,
            style: TextStyle(fontSize: DesignTokens.fontLG),
          ),
          content: description != null ? Text(description) : null,
          actions: [
            RoundedButtonWidget.dark(
              onTap: onPressed,
              label: buttonLabel,
            ),
          ],
        ),
      );
}
