import 'package:equatable/equatable.dart';

import 'package:marketplace/src/data/models/offer_model.dart';

class CustomerModel extends Equatable {
  const CustomerModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.offers,
  });

  final String id;
  final String name;
  final int balance;
  final List<OfferModel> offers;

  factory CustomerModel.fromJson(Map<String, Object?> json) => CustomerModel(
        id: json['id'] as String,
        name: json['name'] as String,
        balance: json['balance'] as int,
        offers: OfferModel.fromJsonList(
          json['offers'] as List<Object?>,
        ),
      );

  @override
  List<Object?> get props => [id, name, balance, offers];
}
