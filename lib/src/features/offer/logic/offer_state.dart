part of 'offer_cubit.dart';

class OfferState extends Equatable {
  final PurchaseResponseModel? purchaseResponse;
  final bool isLoading;

  const OfferState._({
    this.purchaseResponse,
    this.isLoading = false,
  });

  factory OfferState.initial() => OfferState._();

  factory OfferState.loading() => OfferState._(
        isLoading: true,
      );

  factory OfferState.response(PurchaseResponseModel purchaseResponse) =>
      OfferState._(
        purchaseResponse: purchaseResponse,
        isLoading: false,
      );

  @override
  List<Object?> get props => [purchaseResponse, isLoading];

  @override
  String toString() => '''OfferState {
    purchaseResponse: $purchaseResponse
    isLoading: $isLoading
  }''';
}
