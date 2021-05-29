import 'package:equatable/equatable.dart';
import 'package:marketplace/src/common/models/product_model.dart';

class OfferModel extends Equatable {
  const OfferModel({
    required this.id,
    required this.price,
    required this.product,
  });

  final String id;
  final int price;
  final ProductModel product;

  factory OfferModel.fromJson(Map<String, Object?> json) => OfferModel(
        id: json['id'] as String,
        price: json['price'] as int,
        product: ProductModel.fromJson(json['product'] as Map<String, Object?>),
      );

  static List<OfferModel> fromJsonList(List<Object?> list) =>
      List<OfferModel>.from(
        list.map<OfferModel>(
          (x) => OfferModel.fromJson(x as Map<String, Object?>),
        ),
      );

  @override
  List<Object?> get props => [id, price, product];
}
