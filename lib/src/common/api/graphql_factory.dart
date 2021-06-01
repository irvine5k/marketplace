import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/repositories/token_repository.dart';

class GraphQlClientFactory {
  final TokenRepository tokenRepository;

  const GraphQlClientFactory({required this.tokenRepository});

  ValueNotifier<GraphQLClient> getClientValueNotifier(
    String serverAddress,
  ) =>
      ValueNotifier(
        _createBluGraphQlClient(serverAddress),
      );

  GraphQLClient _createBluGraphQlClient(String serverAddress) {
    final httpLink = HttpLink(serverAddress);

    final authLink = AuthLink(getToken: tokenRepository.getToken);

    final link = Link.from([authLink, httpLink]);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
