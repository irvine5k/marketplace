import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/utils/utils.dart';

void main() {
  test(
    'When format a default value to monetary '
    'should return a formatted value',
    () {
      expect(Utils.formatToMonetaryValueFromInteger(55801), '\$558.01');
    },
  );

  test(
    'When format a zero value to monetary '
    'should return a formatted value',
    () {
      expect(Utils.formatToMonetaryValueFromInteger(0), '\$0.00');
    },
  );
}
