import '../../domain/entities/product.dart';

abstract class ProductLocalDataSourceContract {
  List<Product> getAllProducts();
  Product? getProductById(String id);
  void createProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(String id);
}
