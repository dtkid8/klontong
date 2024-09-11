// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product_response.dart';

class Product {
  final int categoryId;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final int weight;
  final int width;
  final int length;
  final int height;
  final String image;
  final int harga;
  final String id;
  Product({
    required this.categoryId,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.harga,
    required this.id,
  });

  Product copyWith({
    int? categoryId,
    String? categoryName,
    String? sku,
    String? name,
    String? description,
    int? weight,
    int? width,
    int? length,
    int? height,
    String? image,
    int? harga,
    String? id,
  }) {
    return Product(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      image: image ?? this.image,
      harga: harga ?? this.harga,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'harga': harga,
      'id': id,
    };
  }

  factory Product.fromResponse(ProductResponse response) => Product(
        categoryId: response.categoryId ?? 0,
        categoryName: response.categoryName ?? "",
        sku: response.sku ?? "",
        name: response.name ?? "",
        description: response.description ?? "",
        weight: response.weight ?? 0,
        width: response.width ?? 0,
        length: response.length ?? 0,
        height: response.height ?? 0,
        image: response.image ?? "",
        harga: response.harga ?? 0,
        id: response.id ?? "",
      );

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      categoryId: map['categoryId'] as int,
      categoryName: map['categoryName'] as String,
      sku: map['sku'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      weight: map['weight'] as int,
      width: map['width'] as int,
      length: map['length'] as int,
      height: map['height'] as int,
      image: map['image'] as String,
      harga: map['harga'] as int,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(categoryId: $categoryId, categoryName: $categoryName, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, harga: $harga, id: $id)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.sku == sku &&
        other.name == name &&
        other.description == description &&
        other.weight == weight &&
        other.width == width &&
        other.length == length &&
        other.height == height &&
        other.image == image &&
        other.harga == harga &&
        other.id == id;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        categoryName.hashCode ^
        sku.hashCode ^
        name.hashCode ^
        description.hashCode ^
        weight.hashCode ^
        width.hashCode ^
        length.hashCode ^
        height.hashCode ^
        image.hashCode ^
        harga.hashCode ^
        id.hashCode;
  }
}
