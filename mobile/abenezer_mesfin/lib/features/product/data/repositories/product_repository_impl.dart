import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source_contract.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSourceContract dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<void> addProduct(Product product) async {
    dataSource.createProduct(product);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return dataSource.getAllProducts();
  }

  @override
  Future<Product?> getProductById(String id) async {
    return dataSource.getProductById(id);
  }

  @override
  Future<void> createProduct(Product product) async {
    dataSource.createProduct(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    dataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    dataSource.deleteProduct(id);
  }
}

























// import '../../domain/entities/product.dart';
// import '../../domain/repositories/product_repository.dart';
// import '../datasources/product_local_data_source.dart';

// class ProductRepositoryImpl implements ProductRepository {
//   final ProductLocalDataSource dataSource;

//   ProductRepositoryImpl(this.dataSource);
// @override
// Future<void> addProduct(Product product) async {
//   return dataSource.createProduct(product); // or just await if needed
// }

//   @override
//   Future<List<Product>> getAllProducts() async {
//     return dataSource.getAllProducts();
//   }

//   @override
//   Future<Product?> getProductById(String id) async {
//     return dataSource.getProductById(id);
//   }

//   @override
//   Future<void> createProduct(Product product) async {
//     dataSource.createProduct(product);
//   }

//   @override
//   Future<void> updateProduct(Product product) async {
//     dataSource.updateProduct(product);
//   }

//   @override
//   Future<void> deleteProduct(String id) async {
//     dataSource.deleteProduct(id);
//   }
// }


