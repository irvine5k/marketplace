import 'package:graphql/client.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:marketplace/src/common/api/marketplace_queries.dart';

abstract class OfferRepository {
  Future<PurchaseResponseModel> purchase(String offerId);
}

class GraphQLPurchaseRepository implements OfferRepository {
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
