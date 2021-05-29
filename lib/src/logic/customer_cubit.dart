import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(this._repository) : super(InitialState());

  final CustomerRepository _repository;

  CustomerModel? _customerModel;

  Future<void> getCustomer() async {
    try {
      final customer = await _repository.getCustomer();

      emit(LoadedState(customer: customer));
    } catch (e) {
      emit(ErrorState(customer: _customerModel));
    }
  }
}
