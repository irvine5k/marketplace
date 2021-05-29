import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/src/common/constants/theme.dart';

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
      withSymbol: withSymbol,
      isNegative: isNegative,
      withCurrencySymbol: withCurrencySymbol,
      withThousandSeparator: withThousandSeparator,
    );
  }

  static String formatToMonetaryValue(
    double value, {
    bool withSymbol = false,
    bool isNegative = false,
    bool withCurrencySymbol = true,
    bool withSpaceOnCurrencySymbol = true,
    bool withThousandSeparator = false,
  }) {
    var symbol = '';
    if (withSymbol && value > 0.0) symbol = isNegative ? '- ' : '+ ';

    final currSymbol =
        withCurrencySymbol ? (withSpaceOnCurrencySymbol ? 'R\$ ' : 'R\$') : '';
    final prefixValue = symbol + currSymbol;

    return NumberFormat.currency(
      locale: 'pt_BR',
      customPattern: withThousandSeparator && value > 0.0
          ? '$prefixValue###,##0.00'
          : '$prefixValue###0.0#',
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
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.black),
          ),
          content: description != null ? Text(description) : null,
          actions: [
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonLabel),
            ),
          ],
        ),
      );
}
