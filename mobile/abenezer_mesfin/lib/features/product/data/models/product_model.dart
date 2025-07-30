import '/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String imagePath,
    required String desc,
    required String price,
  }) : super(
          id: id,
          name: name,
          imagePath: imagePath,
          desc: desc,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      desc: json['desc'],
      price: json['price'],
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
}
