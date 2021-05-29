import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/purchase_response_model.dart';
import 'package:marketplace/src/data/repositories/purchase_repository.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit(this._repository) : super(PurchaseState.initial());

  final PurchaseRepository _repository;

  Future<void> purchase(String offerId) async {
    emit(PurchaseState.loading());

    final purchaseResponse = await _repository.purchase(offerId);

    emit(PurchaseState.response(purchaseResponse));
  }
}
