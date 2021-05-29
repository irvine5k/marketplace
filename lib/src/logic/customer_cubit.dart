import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(this._repository) : super(CustomerState.initial());

  final CustomerRepository _repository;

  Future<void> getCustomer() async {
    try {
      emit(CustomerState.loading());

      final customer = await _repository.getCustomer();

      emit(CustomerState.fetched(customer));
    } catch (e) {
      emit(CustomerState.error());
    }
  }

  Future<void> setCustomer(CustomerModel? customer) async {
    if (customer != null) {
      emit(CustomerState.fetched(customer));
    }
  }
}
