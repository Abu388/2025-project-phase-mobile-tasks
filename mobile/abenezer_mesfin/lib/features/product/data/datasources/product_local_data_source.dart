import '../../domain/entities/product.dart';
import 'mock_product_data.dart';
import 'product_local_data_source_contract.dart';

class ProductLocalDataSource implements ProductLocalDataSourceContract {
  final List<Product> _products = List.from(mockProducts);

  @override
  Future<List<Product>> getAllProducts() async => Future.value(_products);

  @override
  Future<Product?> getProductById(String id) async {
    try {
      final product = _products.firstWhere((product) => product.id == id);
      return Future.value(product);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    _products.add(product);
  }

  @override
  Future<void> updateProduct(Product updatedProduct) async {
    final index = _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    _products.removeWhere((product) => product.id == id);
  }
}


// import '../../domain/entities/product.dart';

// import 'mock_product_data.dart'; // import the mock data

// class ProductLocalDataSource {
//   final List<Product> _products = mockProducts; // inject mock data

//   List<Product> getAllProducts() {
//     return _products;
//   }

//   Product? getProductById(String id) {
//     try {
//       return _products.firstWhere((product) => product.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   void createProduct(Product product) {
//     _products.add(product);
//   }

//   void updateProduct(Product updatedProduct) {
//     final index = _products.indexWhere((product) => product.id == updatedProduct.id);
//     if (index != -1) {
//       _products[index] = updatedProduct;
//     }
//   }

//   void deleteProduct(String id) {
//     _products.removeWhere((product) => product.id == id);
//   }
// }
