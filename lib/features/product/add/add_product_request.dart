// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddProductRequest {
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
  AddProductRequest({
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
  });

  AddProductRequest copyWith({
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
  }) {
    return AddProductRequest(
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CategoryId': categoryId,
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
    };
  }

  factory AddProductRequest.fromMap(Map<String, dynamic> map) {
    return AddProductRequest(
      categoryId: map['CategoryId'] as int,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductRequest.fromJson(String source) => AddProductRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddProductRequest(categoryId: $categoryId, categoryName: $categoryName, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, harga: $harga)';
  }

  @override
  bool operator ==(covariant AddProductRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.categoryId == categoryId &&
      other.categoryName == categoryName &&
      other.sku == sku &&
      other.name == name &&
      other.description == description &&
      other.weight == weight &&
      other.width == width &&
      other.length == length &&
      other.height == height &&
      other.image == image &&
      other.harga == harga;
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
      harga.hashCode;
  }
}

