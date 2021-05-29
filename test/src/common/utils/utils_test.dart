import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/utils/utils.dart';

void main() {
  group('Method formatToMonetaryValue - ', () {
    test(
      'When format a double to monetary '
      'should return a formatted value',
      () {
        expect(Utils.formatToMonetaryValue(22.50), 'R\$ 22,50');
      },
    );

    test(
        'When format a zero to monetary '
        'should return a formatted value', () {
      final returned = Utils.formatToMonetaryValue(0);

      expect(returned, 'R\$ 0,00');
    });

    test(
        'When format a double to monetary without currency symbol'
        'should return a formatted value', () {
      final returned =
          Utils.formatToMonetaryValue(0, withCurrencySymbol: false);

      expect(returned, '0,00');
    });
  });

  group('Test formatToMonetaryValueFromInteger', () {
    test(
      'When format a double to monetary '
      'should return a formatted value',
      () {
        expect(Utils.formatToMonetaryValueFromInteger(55801), 'R\$ 558,01');
      },
    );

    test(
      'When format a double to monetary '
      'should return a formatted value',
      () {
        expect(
            Utils.formatToMonetaryValueFromInteger(
              55801,
              withCurrencySymbol: false,
            ),
            '558,01');
      },
    );
  });
}
