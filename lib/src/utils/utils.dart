import 'package:intl/intl.dart';

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
        withCurrencySymbol ? (withSpaceOnCurrencySymbol ? '\$ ' : '\$') : '';
    final prefixValue = symbol + currSymbol;

    return NumberFormat.currency(
      locale: 'pt_BR',
      customPattern: withThousandSeparator && value > 0.0
          ? '$prefixValue###,##0.00'
          : '$prefixValue###0.0#',
    ).format(value);
  }
}
