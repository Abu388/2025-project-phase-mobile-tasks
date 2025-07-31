import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSourceContract {
  Future<List<Product>> getAllProducts();
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}
