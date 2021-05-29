import 'package:flutter/material.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';
import 'package:marketplace/src/data/repositories/token_repository.dart';
import 'package:marketplace/src/data/api/graphql_factory.dart';
import 'package:marketplace/src/ui/home_page.dart';
import 'package:marketplace/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

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
        theme: AppTheme.theme,
        home: HomePage(repository: customerRepository),
      ),
    );
  }
}
