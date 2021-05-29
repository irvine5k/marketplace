import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/product_model.dart';

void main() {
  test('When call fromJson should return a correct model', () {
    final product = ProductModel.fromJson(_productJson);

    expect(product.id, _id);
    expect(product.name, _name);
    expect(product.description, _description);
    expect(product.image, _image);
  });
  test('When compare two objects with same values, should return true', () {
    final product1 = ProductModel.fromJson(_productJson);
    final product2 = ProductModel.fromJson(_productJson);

    expect(product1, product2);
  });
}

final _id = 'product/portal-gun';
final _name = 'Portal Gun';
final _description =
    'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.';
final _image =
    'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310';

final _productJson = {
  'id': _id,
  'name': _name,
  'description': _description,
  'image': _image,
};
