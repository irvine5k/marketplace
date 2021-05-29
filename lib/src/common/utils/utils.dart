import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';

class Utils {
  static String formatToMonetaryValueFromInteger(
    int value, {
    bool withSymbol = false,
    bool isNegative = false,
    bool withCurrencySymbol = true,
    bool withThousandSeparator = true,
  }) {
    return formatToMonetaryValue(
      value == 0 ? 0 : value / 100,
      withCurrencySymbol: withCurrencySymbol,
    );
  }

  static String formatToMonetaryValue(
    double value, {
    bool withCurrencySymbol = true,
  }) {
    final currencySymbol = withCurrencySymbol ? 'R\$ ' : '';

    return NumberFormat.currency(
      locale: 'pt_BR',
      customPattern: '$currencySymbol###0.0#',
    ).format(value);
  }

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
          title: Text(
            'Success',
            style: TextStyle(fontSize: DesignTokens.fontLG),
          ),
          content: description != null ? Text(description) : null,
          actions: [
            RoundedButtonWidget(
              onTap: onPressed,
              label: buttonLabel,
            ),
          ],
        ),
      );
}
