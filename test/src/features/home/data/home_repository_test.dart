import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

final _data = {
  'viewer': {
    'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
    'name': 'Jerry Smith',
    'balance': 100000,
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
  }
};

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
      when(() => client.query(any())).thenAnswer(
        (_) async => QueryResult(
          data: _data,
          source: QueryResultSource.network,
        ),
      );

      final result = await repository.getCustomer();

      expect(result, CustomerModel.fromJson(_data['viewer']!));
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
