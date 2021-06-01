import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/resources/messages.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../mocks.dart';

late OfferRepository _repository;

final _purchaseFailResponse = PurchaseResponseModel.fromJson(
    Mocks.purchaseResponseFailJson['purchase']! as Map<String, Object?>);
final _purchaseSuccessResponse = PurchaseResponseModel.fromJson(
  Mocks.purchaseResponseSuccessJson['purchase']! as Map<String, Object?>,
);
final _customerJson =
    Mocks.customerViewerJson['viewer']! as Map<String, Object?>;

final _customer = CustomerModel.fromJson(_customerJson);

void main() {
  setUp(() {
    _repository = MockOfferRepository();
  });

  testWidgets(
    'When create OfferPage '
    'should find the correct widgets',
    (tester) async {
      await _createWidget(tester);

      await tester.pump();

      expect(
        find.text(_customer.offers.first.product.name),
        findsOneWidget,
      );
      expect(
        find.text(_customer.offers.first.product.description),
        findsOneWidget,
      );

      final buyNowText = AppMessages.buyNow(
        Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        ),
      );

      expect(
        find.text(buyNowText),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'When purchase is successful '
    'should find the success dialog',
    (tester) async {
      when(() => _repository.purchase(any()))
          .thenAnswer((_) async => _purchaseSuccessResponse);

      await _createWidget(tester);

      await tester.pump();

      final offer = _customer.offers.first;

      final buyNowText = AppMessages.buyNow(
        Utils.formatToMonetaryValueFromInteger(
          offer.price,
        ),
      );

      await tester.tap(find.text(buyNowText));

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.text(AppMessages.success), findsOneWidget);
      expect(
        find.text(
          AppMessages.purchaseSuccessDescription(
            name: offer.product.name,
            price: Utils.formatToMonetaryValueFromInteger(
              offer.price,
            ),
          ),
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'When purchase fails '
    'should find the error dialog',
    (tester) async {
      when(() => _repository.purchase(any()))
          .thenAnswer((_) async => _purchaseFailResponse);

      await _createWidget(tester);

      await tester.pump();

      final buyNowText = AppMessages.buyNow(
        Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        ),
      );

      await tester.tap(find.text(buyNowText));

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.text(_purchaseFailResponse.errorMessage), findsOneWidget);
    },
  );

  testWidgets(
    'When Server Error '
    'should find the error dialog',
    (tester) async {
      when(() => _repository.purchase(any())).thenThrow(Exception());

      await _createWidget(tester);

      await tester.pump();

      final buyNowText = AppMessages.buyNow(
        Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        ),
      );

      await tester.tap(find.text(buyNowText));

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.text(AppMessages.serverError), findsOneWidget);
    },
  );
}

Future<void> _createWidget(WidgetTester tester) async {
  await mockNetworkImages(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: OfferPage(
          purchaseRepository: _repository,
          balance: _customer.balance,
          offer: _customer.offers.first,
        ),
      ),
    );
  });
}
