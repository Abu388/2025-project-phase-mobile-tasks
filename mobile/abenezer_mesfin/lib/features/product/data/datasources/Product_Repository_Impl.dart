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
        await localDataSource.createProduct(product); // Added await here
      } catch (e) {
        await localDataSource.createProduct(product);
        throw Exception('Failed to add product remotely: $e');
      }
    } else {
      await localDataSource.createProduct(product);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        // Optionally cache locally:
        // await localDataSource.cacheProducts(products);
        return products;
      } catch (e) {
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
    return await localDataSource.getProductById(id);
  }

  @override
  Future<void> createProduct(Product product) async {
    return addProduct(product);
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
    await localDataSource.updateProduct(product);  // Added await here
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
    await localDataSource.deleteProduct(id); // Added await here
  }
}
