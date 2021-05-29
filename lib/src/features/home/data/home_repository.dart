import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/api/marketplace_queries.dart';

abstract class HomeRepository {
  Future<CustomerModel> getCustomer();
}

class GraphQLHomeRepository implements HomeRepository {
  final GraphQLClient _client;

  GraphQLHomeRepository(this._client);

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
