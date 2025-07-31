import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/product.dart';
import 'product_local_data_source_contract.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSourceContract {
  static const String cachedProductsKey = 'CACHED_PRODUCTS';

  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> createProduct(Product product) async {
    final products = await getAllProducts();
    products.add(product);
    await _cacheProducts(products);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final products = await getAllProducts();
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
      await _cacheProducts(products);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final products = await getAllProducts();
    products.removeWhere((p) => p.id == id);
    await _cacheProducts(products);
  }

  @override
  Future<Product?> getProductById(String id) async {
    final products = await getAllProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> _cacheProducts(List<Product> products) async {
    final jsonString =
        json.encode(products.map((product) => product.toJson()).toList());
    await sharedPreferences.setString(cachedProductsKey, jsonString);
  }
}
