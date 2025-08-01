import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/product.dart';
import '../models/product_model.dart';
import 'product_remote_data_source_contract.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSourceContract {
  final http.Client client;

  final String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(Uri.parse(baseUrl));

    print('📡 [RemoteDataSource] Fetched raw response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Product> products = decoded
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      print('✅ [RemoteDataSource] Parsed products: $products');
      return products;
    } else {
      print('❌ [RemoteDataSource] Failed with status code: ${response.statusCode}');
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ProductModel.fromEntity(product).toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create product');
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ProductModel.fromEntity(product).toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}



