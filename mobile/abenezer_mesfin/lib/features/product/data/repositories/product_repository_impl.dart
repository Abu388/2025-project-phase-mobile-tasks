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
      try {
        await remoteDataSource.createProduct(product);
        localDataSource.createProduct(product); // cache locally
      } catch (e) {
        // handle remote failure, still cache locally
        localDataSource.createProduct(product);
        throw Exception('Failed to add product remotely: $e');
      }
    } else {
      // no internet - cache locally only
      localDataSource.createProduct(product);
      // optionally throw if you want to notify no remote add
      // throw Exception('No internet connection to add product remotely.');
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        // cache locally if you want
        // await localDataSource.cacheProducts(products);
        return products;
      } catch (e) {
        // failed to fetch remote, fallback to local cache
        final localProducts = await localDataSource.getAllProducts();
        if (localProducts.isNotEmpty) {
          return localProducts;
        } else {
          throw Exception('Failed to fetch products remotely and no cached data: $e');
        }
      }
    } else {
      final localProducts = await localDataSource.getAllProducts();
      if (localProducts.isNotEmpty) {
        return localProducts;
      } else {
        throw Exception('No internet connection and no cached data.');
      }
    }
  }

  @override
  Future<Product?> getProductById(String id) async {
    // This only fetches from local, no network involved
    return await localDataSource.getProductById(id);
  }

  @override
  Future<void> createProduct(Product product) async {
    return addProduct(product); // reuse logic
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProduct(product);
      } catch (e) {
        throw Exception('Failed to update product remotely: $e');
      }
    } else {
      throw Exception('No internet connection to update product remotely.');
    }
    localDataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
      } catch (e) {
        throw Exception('Failed to delete product remotely: $e');
      }
    } else {
      throw Exception('No internet connection to delete product remotely.');
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


