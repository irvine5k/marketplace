import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/api/graphql_factory.dart';
import 'package:marketplace/src/common/repositories/token_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenRepository extends Mock implements TokenRepository {}

void main() {
  late TokenRepository tokenRepository;
  late GraphQlClientFactory graphQlClientFactory;

  setUp(() {
    tokenRepository = MockTokenRepository();
    graphQlClientFactory = GraphQlClientFactory(
      tokenRepository: tokenRepository,
    );
  });

  test(
    'When Get GraphQL Client Notifier '
    'should return a GraphQLClient in its value',
    () {
      expect(
        graphQlClientFactory.getClientValueNotifier('').value,
        isA<GraphQLClient>(),
      );
    },
  );
}
