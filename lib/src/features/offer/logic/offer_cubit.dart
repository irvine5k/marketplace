import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/features/offer/data/purchase_response_model.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this._repository) : super(OfferState.initial());

  final OfferRepository _repository;

  Future<void> purchase(String offerId) async {
    try {
      emit(OfferState.loading());

      final purchaseResponse = await _repository.purchase(offerId);

      emit(OfferState.response(purchaseResponse));
    } catch (_) {
      emit(OfferState.error());
    }
  }
}
