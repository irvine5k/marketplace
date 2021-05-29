import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/purchase_response_model.dart';
import 'package:marketplace/src/data/repositories/offer_repository.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this._repository) : super(OfferState.initial());

  final OfferRepository _repository;

  Future<void> purchase(String offerId) async {
    emit(OfferState.loading());

    final purchaseResponse = await _repository.purchase(offerId);

    emit(OfferState.response(purchaseResponse));
  }
}
