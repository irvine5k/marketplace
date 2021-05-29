import 'package:equatable/equatable.dart';
import 'package:marketplace/src/common/models/customer_model.dart';

class PurchaseResponseModel extends Equatable {
  const PurchaseResponseModel({
    required this.success,
    required this.errorMessage,
    required this.customer,
  });

  final bool success;
  final String errorMessage;
  final CustomerModel customer;

  factory PurchaseResponseModel.fromJson(Map<String, Object?> json) =>
      PurchaseResponseModel(
        success: json['success'] as bool,
        errorMessage:
            json['errorMessage'] != null ? json['errorMessage'] as String : '',
        customer:
            CustomerModel.fromJson(json['customer'] as Map<String, Object?>),
      );

  @override
  List<Object?> get props => [success, errorMessage, customer];
}
