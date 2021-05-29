import 'package:marketplace/src/data/models/customer_model.dart';

class PurchaseResponseModel {
  const PurchaseResponseModel({
    required this.success,
    required this.errorMessage,
    required this.customer,
  });

  final bool success;
  final String errorMessage;
  final CustomerModel customer;

  factory PurchaseResponseModel.fromJson(Map<String, dynamic> json) =>
      PurchaseResponseModel(
        success: json["success"],
        errorMessage: json["errorMessage"] ?? '',
        customer: CustomerModel.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorMessage": errorMessage,
        "customer": customer.toJson(),
      };
}
