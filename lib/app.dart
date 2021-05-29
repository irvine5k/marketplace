import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace/src/common/api/graphql_factory.dart';
import 'package:marketplace/src/common/constants/server_address.dart';
import 'package:marketplace/src/common/repositories/token_repository.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/ui/home_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final graphQlClientNotifier = GraphQlClientFactory(
      authenticationService: MockTokenRepository(),
    ).getClientValueNotifier(serverAddress);

    final customerRepository = GraphQLCustomerRepository(
      graphQlClientNotifier.value,
    );

    return ValueListenableProvider.value(
      value: graphQlClientNotifier,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marketplace',
        home: HomePage(repository: customerRepository),
      ),
    );
  }
}
