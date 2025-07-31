




import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source_contract.dart';
import '../datasources/product_remote_data_source_contract.dart';
import '../network/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSourceContract localDataSource;
  final ProductRemoteDataSourceContract remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.createProduct(product);
      localDataSource.createProduct(product); // optional cache
    } else {
      localDataSource.createProduct(product);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      final products = await remoteDataSource.getAllProducts();
      // optional: cache them locally
      return products;
    } else {
      return localDataSource.getAllProducts();
    }
  }

  @override
  Future<Product?> getProductById(String id) async {
    return localDataSource.getProductById(id);
  }

  @override
  Future<void> createProduct(Product product) async {
    return addProduct(product); // reuse logic
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(product);
    }
    localDataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
    }
    localDataSource.deleteProduct(id);
  }
}





















// import '../../domain/entities/product.dart';
// import '../../domain/repositories/product_repository.dart';
// import '../datasources/product_local_data_source_contract.dart';

// class ProductRepositoryImpl implements ProductRepository {
//   final ProductLocalDataSourceContract dataSource;

//   ProductRepositoryImpl(this.dataSource);

//   @override
//   Future<void> addProduct(Product product) async {
//     dataSource.createProduct(product);
//   }

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


