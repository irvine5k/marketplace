import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:marketplace/src/features/offer/logic/offer_cubit.dart';

import '../../../mocks.dart';

final _responseFailJson =
    Mocks.purchaseResponseFailJson['purchase']! as Map<String, Object?>;
final _responseSuccessJson =
    Mocks.purchaseResponseSuccessJson['purchase']! as Map<String, Object?>;

final _purchaseFailResponse = PurchaseResponseModel.fromJson(_responseFailJson);
final _purchaseSuccessResponse =
    PurchaseResponseModel.fromJson(_responseSuccessJson);

void main() {
  late OfferRepository repository;

  setUp(() {
    repository = MockOfferRepository();
  });

  blocTest<OfferCubit, OfferState>(
    'When a purchase is successful should emit a OfferState.success',
    build: () {
      when(() => repository.purchase(any()))
          .thenAnswer((_) async => _purchaseSuccessResponse);

      return OfferCubit(repository);
    },
    act: (cubit) => cubit.purchase(''),
    expect: () => [
      OfferState.loading(),
      OfferState.response(_purchaseSuccessResponse),
    ],
  );

  blocTest<OfferCubit, OfferState>(
    'When a purchase fails should emit a OfferState.response with success false',
    build: () {
      when(() => repository.purchase(any()))
          .thenAnswer((_) async => _purchaseFailResponse);

      return OfferCubit(repository);
    },
    act: (cubit) => cubit.purchase(''),
    expect: () => [
      OfferState.loading(),
      OfferState.response(_purchaseFailResponse),
    ],
  );

  blocTest<OfferCubit, OfferState>(
    'When a purchase fails should emit a OfferState.error',
    build: () {
      when(() => repository.purchase(any())).thenThrow(Exception());

      return OfferCubit(repository);
    },
    act: (cubit) => cubit.purchase(''),
    expect: () => [
      OfferState.loading(),
      OfferState.error(),
    ],
  );
}
