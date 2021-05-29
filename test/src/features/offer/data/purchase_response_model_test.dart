import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';

import '../../../mocks.dart';

final _json =
    Mocks.purchaseResponseSuccessJson['purchase'] as Map<String, Object?>;

void main() {
  test('When call fromJson should return a correct model', () {
    final purchaseResponse = PurchaseResponseModel.fromJson(_json);

    expect(purchaseResponse.success, true);
    expect(purchaseResponse.errorMessage, '');
  });
  test('When compare two objects with same values, should return true', () {
    final purchaseResponse1 = PurchaseResponseModel.fromJson(_json);
    final purchaseResponse2 = PurchaseResponseModel.fromJson(_json);

    expect(purchaseResponse1, purchaseResponse2);
  });
}
