// product_local_data_source_contract.dart
import '../../domain/entities/product.dart';

abstract class ProductLocalDataSourceContract {
  Future<List<Product>> getAllProducts();
  Future<Product?> getProductById(String id);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}
