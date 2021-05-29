part of 'purchase_cubit.dart';

class PurchaseState extends Equatable {
  final PurchaseResponseModel? purchaseResponse;
  final bool isLoading;

  const PurchaseState._({
    this.purchaseResponse,
    this.isLoading = false,
  });

  factory PurchaseState.initial() => PurchaseState._();

  factory PurchaseState.loading() => PurchaseState._(
        isLoading: true,
      );

  factory PurchaseState.response(PurchaseResponseModel purchaseResponse) =>
      PurchaseState._(
        purchaseResponse: purchaseResponse,
        isLoading: false,
      );

  @override
  List<Object?> get props => [purchaseResponse, isLoading];
}
