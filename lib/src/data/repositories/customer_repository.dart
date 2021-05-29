import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/queries/marketplace_queries.dart';

abstract class CustomerRepository {
  Future<CustomerModel> getCustomer();
}

class GraphQLCustomerRepository implements CustomerRepository {
  final GraphQLClient _client;

  GraphQLCustomerRepository(this._client);

  @override
  Future<CustomerModel> getCustomer() async {
    final result = await _client.query(
      QueryOptions(document: gql(Queries.customer)),
    );

    if (result.hasException) {
      throw Exception();
    } else {
      final data = result.data!['viewer'] as Map<String, Object?>;

      final customer = CustomerModel.fromJson(data);

      return customer;
    }
  }
}
