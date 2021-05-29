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

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        name: json["name"],
        balance: json["balance"],
        offers: List<OfferModel>.from(
            json["offers"].map((x) => OfferModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "balance": balance,
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [id, name, balance, offers];
}
