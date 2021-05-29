import 'package:marketplace/src/marketplace/data/models/product_model.dart';

class OfferModel {
  const OfferModel({
    required this.id,
    required this.price,
    required this.product,
  });

  final String id;
  final int price;
  final ProductModel product;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        price: json["price"],
        product: ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "product": product.toJson(),
      };
}
