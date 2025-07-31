import '../../domain/entities/product.dart';
import 'product_remote_data_source_contract.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSourceContract {
  @override
  Future<List<Product>> getAllProducts() async {
    // TODO: fetch from API or return empty list for now
    return [];
  }

  @override
  Future<void> createProduct(Product product) async {
    // TODO: send product to API
  }

  @override
  Future<void> updateProduct(Product product) async {
    // TODO: update product on API
  }

  @override
  Future<void> deleteProduct(String id) async {
    // TODO: delete product from API
  }
}
