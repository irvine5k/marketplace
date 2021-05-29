import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/purchase_response_model.dart';
import 'package:marketplace/src/data/queries/marketplace_queries.dart';

abstract class PurchaseRepository {
  Future<PurchaseResponseModel> purchase(String offerId);
}

class GraphQLPurchaseRepository implements PurchaseRepository {
  final GraphQLClient _client;

  GraphQLPurchaseRepository(this._client);

  @override
  Future<PurchaseResponseModel> purchase(String offerId) async {
    final result = await _client.mutate(
      MutationOptions(document: gql(Mutations.purchase(offerId))),
    );

    if (result.hasException) {
      throw Exception();
    } else {
      final data = result.data!['purchase'] as Map<String, Object?>;

      final purchaseResponse = PurchaseResponseModel.fromJson(data);

      return purchaseResponse;
    }
  }
}
