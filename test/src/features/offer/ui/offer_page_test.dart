import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:mocktail/mocktail.dart';

class MockOfferRepository extends Mock implements OfferRepository {}

class MockGraphQLClient extends Mock implements GraphQLClient {}

late OfferRepository _repository;

final _responseFailJson = {
  'success': false,
  'errorMessage': "You don't have that much money.",
  'customer': {
    'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
    'name': 'Jerry Smith',
    'balance': 1000000,
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
        'id': 'offer/microverse-battery',
        'price': 5507,
        'product': {
          'id': 'product/microverse-battery',
          'name': 'Microverse Battery',
          'description':
              'The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946'
        }
      },
      {
        'id': 'offer/mr-meeseeks-box',
        'price': 999999999,
        'product': {
          'id': 'product/mr-meeseeks-box',
          'name': 'Mr. Meeseeks Box',
          'description':
              'The Mr. Meeseeks Box is a gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest/scale-to-width-down/310?cb=20160909153718'
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
  }
};

final _responseSuccessJson = {
  'success': true,
  'errorMessage': null,
  'customer': {
    'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
    'name': 'Jerry Smith',
    'balance': 995000,
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
        'id': 'offer/microverse-battery',
        'price': 5507,
        'product': {
          'id': 'product/microverse-battery',
          'name': 'Microverse Battery',
          'description':
              'The Microverse Battery contains a miniature universe with a planet inhabited by intelligent life.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest/scale-to-width-down/310?cb=20160910010946'
        }
      },
      {
        'id': 'offer/mr-meeseeks-box',
        'price': 999999999,
        'product': {
          'id': 'product/mr-meeseeks-box',
          'name': 'Mr. Meeseeks Box',
          'description':
              'The Mr. Meeseeks Box is a gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.',
          'image':
              'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest/scale-to-width-down/310?cb=20160909153718'
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
  }
};

final _purchaseFailResponse = PurchaseResponseModel.fromJson(_responseFailJson);
final _purchaseSuccessResponse =
    PurchaseResponseModel.fromJson(_responseSuccessJson);

final _customerJson = {
  'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
  'name': 'Jerry Smith',
  'balance': 55801,
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
      expect(
        find.text('Buy Now ${Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        )}'),
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

      await tester.tap(
        find.text('Buy Now ${Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        )}'),
      );

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.text('Success'), findsOneWidget);
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

      await tester.tap(
        find.text('Buy Now ${Utils.formatToMonetaryValueFromInteger(
          _customer.offers.first.price,
        )}'),
      );

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.text(_purchaseFailResponse.errorMessage), findsOneWidget);
    },
  );
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: OfferPage(
        purchaseRepository: _repository,
        balance: _customer.balance,
        offer: _customer.offers.first,
      ),
    ),
  );
}
