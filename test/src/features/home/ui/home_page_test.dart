import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/ui/home_page.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../mocks.dart';

late HomeRepository _repository;

void main() {
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

  setUp(() {
    _repository = MockHomeRepository();
  });

  testWidgets(
    'When create HomePage '
    'should find the correct widgets',
    (tester) async {
      when(() => _repository.getCustomer()).thenAnswer((_) async => _customer);

      await _createWidget(tester);

      await tester.pump();

      expect(
        find.text(Utils.formatToMonetaryValueFromInteger(_customer.balance)),
        findsOneWidget,
      );

      for (final offer in _customer.offers) {
        expect(find.text(offer.product.name), findsOneWidget);
      }
    },
  );

  testWidgets(
    'When navigate to an offer '
    'should find the Offer Page',
    (tester) async {
      when(() => _repository.getCustomer()).thenAnswer((_) async => _customer);

      await _createWidget(tester);

      await tester.pump();

      await tester.tap(find.text(_customer.offers.first.product.name));

      // Cannot use pumpAndSettle because CachedNetworkImage is Loading
      await tester.pump();
      await tester.pump();

      expect(find.byType(OfferPage), findsOneWidget);
    },
  );
}

Future<void> _createWidget(WidgetTester tester) async {
  final graphQlClientNotifier = MockGraphQLClient();

  await tester.pumpWidget(
    ValueListenableProvider<GraphQLClient>.value(
      value: ValueNotifier<GraphQLClient>(graphQlClientNotifier),
      child: MaterialApp(
        home: HomePage(repository: _repository),
      ),
    ),
  );
}
