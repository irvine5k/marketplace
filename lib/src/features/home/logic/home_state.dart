part of 'home_cubit.dart';

class HomeState extends Equatable {
  final CustomerModel? customer;
  final bool isLoading;
  final bool hasError;

  const HomeState._({
    this.customer,
    this.isLoading = false,
    this.hasError = false,
  });

  factory HomeState.initial() => HomeState._();

  factory HomeState.loading() => HomeState._(
        isLoading: true,
        hasError: false,
      );

  factory HomeState.error() => HomeState._(
        hasError: true,
        isLoading: false,
      );

  factory HomeState.fetched(CustomerModel customer) => HomeState._(
        customer: customer,
        hasError: false,
        isLoading: false,
      );

  @override
  List<Object?> get props => [customer, isLoading, hasError];

  @override
  String toString() => '''HomeState {
    customer: $customer
    isLoading: $isLoading
    hasError: $hasError
  }''';
}
