import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late GraphQLClient client;
  late GraphQLHomeRepository repository;

  setUp(() {
    client = MockGraphQLClient();
    repository = GraphQLHomeRepository(client);

    registerFallbackValue(MockQueryOptions());
  });
  test(
    'When getCustomers is successful '
    'should return a Customer',
    () async {
      final customerViewerJson = Mocks.customerViewerJson;
      when(() => client.query(any())).thenAnswer(
        (_) async => QueryResult(
          data: customerViewerJson,
          source: QueryResultSource.network,
        ),
      );

      final result = await repository.getCustomer();

      expect(
        result,
        CustomerModel.fromJson(
          customerViewerJson['viewer'] as Map<String, Object?>,
        ),
      );
    },
  );

  test(
    'When getCustomers fails '
    'should throw a Exception',
    () async {
      when(() => client.query(any())).thenAnswer(
        (_) async => QueryResult(
          source: QueryResultSource.network,
          exception: OperationException(
            graphqlErrors: [
              GraphQLError(message: 'Error'),
            ],
          ),
        ),
      );

      final future = repository.getCustomer();

      expect(future, throwsA(isA<Exception>()));
    },
  );
}
