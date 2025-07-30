import 'package:hello_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  group('ProductModel Test', () {
    final productJson = {
      'id': '1',
      'name': 'Test Item',
      'imagePath': 'images/test.jpg',
      'desc': 'Test description',
      'price': '100',
    };

    final productModel = ProductModel(
      id: '1',
      name: 'Test Item',
      imagePath: 'images/test.jpg',
      desc: 'Test description',
      price: '100',
    );

    test('fromJson should return a valid ProductModel', () {
      final result = ProductModel.fromJson(productJson);

      expect(result.id, productModel.id);
      expect(result.name, productModel.name);
      expect(result.imagePath, productModel.imagePath);
      expect(result.desc, productModel.desc);
      expect(result.price, productModel.price);
    });

    test('toJson should return a valid JSON map', () {
      final result = productModel.toJson();

      expect(result, productJson);
    });
  });
}
