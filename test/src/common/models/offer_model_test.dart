import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/offer_model.dart';

void main() {
  test('When call fromJson should return a correct model', () {
    final offer = OfferModel.fromJson(_offerJson);

    expect(offer.id, _id);
    expect(offer.price, _price);
  });
  test('When compare two objects with same values, should return true', () {
    final offer1 = OfferModel.fromJson(_offerJson);
    final offer2 = OfferModel.fromJson(_offerJson);

    expect(offer1, offer2);
  });
}

final _id = 'offer/portal-gun';
final _price = 5000;

final _offerJson = {
  'id': _id,
  'price': _price,
  'product': {
    'id': 'product/portal-gun',
    'name': 'Portal Gun',
    'description':
        'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
    'image':
        'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
  }
};
