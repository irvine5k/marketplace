import 'package:flutter/material.dart';
import 'package:marketplace/src/common/api/graphql_factory.dart';
import 'package:marketplace/src/common/repositories/token_repository.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/ui/home_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final graphQlClientNotifier = GraphQlClientFactory(
      authenticationService: MockTokenRepository(),
    ).getClientValueNotifier(
      'https://staging-nu-needful-things.nubank.com.br/query',
    );

    final customerRepository = GraphQLCustomerRepository(
      graphQlClientNotifier.value,
    );

    return ValueListenableProvider.value(
      value: graphQlClientNotifier,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(repository: customerRepository),
      ),
    );
  }
}
