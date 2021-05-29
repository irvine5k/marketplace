import 'package:flutter/material.dart';
import 'package:marketplace/src/data/repositories/token_repository.dart';
import 'package:marketplace/src/data/api/graphql_factory.dart';
import 'package:marketplace/src/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final graphQlClientNotifier = GraphQlClientFactory(
      authenticationService: MockTokenRepository(),
    ).getClientValueNotifier(
      'https://staging-nu-needful-things.nubank.com.br/query',
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueListenableProvider.value(
        value: graphQlClientNotifier,
        child: HomePage(),
      ),
    );
  }
}
