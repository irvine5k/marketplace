import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

final _purchaseFailResponse = PurchaseResponseModel.fromJson(
    Mocks.purchaseResponseFailJson['purchase'] as Map<String, Object?>);
final _purchaseSuccessResponse = PurchaseResponseModel.fromJson(
    Mocks.purchaseResponseSuccessJson['purchase'] as Map<String, Object?>);

void main() {
  late GraphQLClient client;
  late GraphQLOfferRepository repository;

  setUp(() {
    client = MockGraphQLClient();
    repository = GraphQLOfferRepository(client);

    registerFallbackValue(MockMutationOptions());
  });
  test(
    'When getCustomers is successful '
    'should return a Customer',
    () async {
      when(() => client.mutate(any())).thenAnswer(
        (_) async => QueryResult(
          data: Mocks.purchaseResponseSuccessJson,
          source: QueryResultSource.network,
        ),
      );

      final result = await repository.purchase('');

      expect(result, _purchaseSuccessResponse);
    },
  );

  test(
    'When getCustomers fails '
    'should throw a Exception',
    () async {
      when(() => client.mutate(any())).thenAnswer(
        (_) async => QueryResult(
          data: Mocks.purchaseResponseFailJson,
          source: QueryResultSource.network,
        ),
      );

      final result = await repository.purchase('');

      expect(result, _purchaseFailResponse);
    },
  );
}
