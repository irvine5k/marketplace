import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/customer_model.dart';

void main() {
  test('When call fromJson should return a correct model', () {
    final customer = CustomerModel.fromJson(_customerJson);

    expect(customer.id, _id);
    expect(customer.name, _name);
    expect(customer.balance, _balance);
    expect(customer.offers.length, 2);
  });
  test('When compare two objects with same values, should return true', () {
    final customer1 = CustomerModel.fromJson(_customerJson);
    final customer2 = CustomerModel.fromJson(_customerJson);

    expect(customer1, customer2);
  });
}

final _name = 'Jerry Smith';
final _id = 'cccc3f48-dd2c-43ba-b8de-8945e7ababab';
final _balance = 1000000;

final _customerJson = {
  'id': _id,
  'name': _name,
  'balance': _balance,
  'offers': [
    {
      'id': 'offer/portal-gun',
      'price': 5000,
      'product': {
        'id': 'product/portal-gun',
        'name': 'Portal Gun',
        'description':
            'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
        'image':
            'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
      }
    },
    {
      'id': 'offer/cognition-amplifier',
      'price': 1000000,
      'product': {
        'id': 'product/cognition-amplifier',
        'name': 'Cognition Amplifier',
        'description': 'The cognition amplifier makes Snuffles smart.',
        'image':
            'https://vignette.wikia.nocookie.net/rickandmorty/images/2/27/Cognition_Amplifier.png/revision/latest/scale-to-width-down/180?cb=20140604001816'
      }
    }
  ]
};
