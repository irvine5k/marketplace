part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  final CustomerModel? customer;
  final bool isLoading;
  final bool hasError;

  const CustomerState._({
    this.customer,
    this.isLoading = false,
    this.hasError = false,
  });

  factory CustomerState.initial() => CustomerState._();

  factory CustomerState.loading() => CustomerState._(
        isLoading: true,
        hasError: false,
      );

  factory CustomerState.error() => CustomerState._(
        hasError: true,
        isLoading: false,
      );

  factory CustomerState.fetched(CustomerModel customer) => CustomerState._(
        customer: customer,
        hasError: false,
        isLoading: false,
      );

  @override
  List<Object?> get props => [customer, isLoading, hasError];
}
