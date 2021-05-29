import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/models/purchase_response_model.dart';
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

  Future<PurchaseResponseModel> purchase(String offerId) async {
    final result = await _client.mutate(
      MutationOptions(document: gql(Mutations.purchase(offerId))),
    );

    if (result.hasException) {
      throw Exception();
    } else {
      final data = result.data!['purchase'];

      final purchaseResponse = PurchaseResponseModel.fromJson(data);

      return purchaseResponse;
    }
  }
}
