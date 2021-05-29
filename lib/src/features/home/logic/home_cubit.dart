import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(HomeState.initial());

  final HomeRepository _repository;

  Future<void> getCustomer() async {
    try {
      emit(HomeState.loading());

      final customer = await _repository.getCustomer();

      emit(HomeState.fetched(customer));
    } catch (e) {
      emit(HomeState.error());
    }
  }

  void setCustomer(CustomerModel? customer) async {
    if (customer != null) {
      emit(HomeState.fetched(customer));
    }
  }
}
