part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {}

class InitialState extends CustomerState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends CustomerState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ErrorState extends CustomerState {
  final CustomerModel? customer;

  ErrorState({this.customer});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadedState extends CustomerState {
  final CustomerModel customer;

  LoadedState({required this.customer});

  @override
  List<Object?> get props => throw UnimplementedError();
}
