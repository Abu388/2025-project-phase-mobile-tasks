import '../../domain/entities/product.dart';

class ProductModel {
  final String id;
  final String name;
  final String imagePath;
  final String desc;
  final String price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.desc,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      imagePath: json['imagePath'],
      desc: json['desc'],
      price: json['price'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'desc': desc,
      'price': price,
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      imagePath: imagePath,
      desc: desc,
      price: price,
    );
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      imagePath: product.imagePath,
      desc: product.desc,
      price: product.price,
    );
  }
}
