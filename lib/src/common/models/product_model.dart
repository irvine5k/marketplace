import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  final String id;
  final String name;
  final String description;
  final String image;

  factory ProductModel.fromJson(Map<String, Object?> json) => ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
      );

  @override
  List<Object?> get props => [id, name, description, image];

  @override
  String toString() => '''{
    id: $id
    name: $name
    description: $description
    image: $image
  }''';
}
