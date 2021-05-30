import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/ui/home_page.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

import '../../../mocks.dart';

late HomeRepository _repository;

void main() {
  final _customer = CustomerModel.fromJson(
      Mocks.customerViewerJson['viewer'] as Map<String, Object?>);

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

  await mockNetworkImages(() async {
    await tester.pumpWidget(
      ValueListenableProvider<GraphQLClient>.value(
        value: ValueNotifier<GraphQLClient>(graphQlClientNotifier),
        child: MaterialApp(
          home: HomePage(repository: _repository),
        ),
      ),
    );
  });
}
