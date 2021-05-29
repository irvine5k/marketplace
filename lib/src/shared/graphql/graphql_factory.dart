import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/shared/authentication/authentication_service.dart';

class GraphQlClientFactory {
  final AuthenticationService authenticationService;

  const GraphQlClientFactory({required this.authenticationService});

  ValueNotifier<GraphQLClient> getClientValueNotifier(
    String serverAddress,
  ) =>
      ValueNotifier(
        _createBluGraphQlClient(serverAddress),
      );

  GraphQLClient _createBluGraphQlClient(String serverAddress) {
    final httpLink = HttpLink('$serverAddress/query');

    final authLink = AuthLink(getToken: authenticationService.getToken);

    final link = Link.from([authLink, httpLink]);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
