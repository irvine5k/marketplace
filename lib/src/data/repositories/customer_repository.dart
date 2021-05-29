import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/queries/marketplace_queries.dart';

class CustomerRepository {
  final GraphQLClient _client;

  CustomerRepository(this._client);

  Future<CustomerModel> getCustomer() async {
    final result = await _client.query(
      QueryOptions(document: gql(Queries.customer)),
    );

    if (result.hasException) {
      throw Exception();
    } else {
      final data = result.data!['viewer'];

      final customer = CustomerModel.fromJson(data);

      return customer;
    }
  }
}
