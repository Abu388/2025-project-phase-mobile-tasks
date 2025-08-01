// import 'package:flutter/material.dart';
// import '../../../injection_container.dart' as di; // make sure this path is correct
// import '../domain/repositories/product_repository.dart';
// import 'pages/details_page.dart';
// import 'pages/home_page.dart';
// import 'pages/search_product.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init(); // 🔧 initialize service locator
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final productRepository = di.sl<ProductRepository>(); // 🎯 resolved from service locator

//     return MaterialApp(
//       title: 'Product Manager',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(productRepository: productRepository),
//         SearchProduct.routeName: (context) =>
//             SearchProduct(productRepository: productRepository),
//         DetailsPage.routeName: (context) =>
//             DetailsPage(productRepository: productRepository),
//       },
//     );
//   }
// }





















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/product_local_data_source.dart'; // Your local data source impl
import '../data/datasources/product_remote_data_source_impl.dart'; // Remote data source impl
import '../data/network/network_info_impl.dart'; // Network info impl
import '../data/repositories/product_repository_impl.dart'; // Repository impl
import '../domain/repositories/product_repository.dart'; // Repository interface
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'pages/search_product.dart';

void main() {
  // Instantiate your data sources and network info
  final productLocalDataSource = ProductLocalDataSource();
  final productRemoteDataSource = ProductRemoteDataSourceImpl(
    client: http.Client(), // Required HTTP client instance
  );
  final networkInfo = NetworkInfoImpl();

  // Create repository with injected dependencies
  final ProductRepository productRepository = ProductRepositoryImpl(
    localDataSource: productLocalDataSource,
    remoteDataSource: productRemoteDataSource,
    networkInfo: networkInfo,
  );

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(productRepository: productRepository),
        SearchProduct.routeName: (context) =>
            SearchProduct(productRepository: productRepository),
        DetailsPage.routeName: (context) =>
            DetailsPage(productRepository: productRepository),
      },
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../data/datasources/product_local_data_source.dart';
// import '../data/datasources/product_remote_data_source_impl.dart';  // <-- new impl
// import '../data/network/network_info_impl.dart';                     // <-- new impl
// import '../data/repositories/product_repository_impl.dart';
// import '../domain/repositories/product_repository.dart';
// import 'pages/details_page.dart';
// import 'pages/home_page.dart';
// import 'pages/search_product.dart';

// void main() {
//   final productLocalDataSource = ProductLocalDataSource();
//   final productRemoteDataSource = ProductRemoteDataSourceImpl(
//     client: http.Client(), // ✅ pass the required http.Client
//   );
//   final networkInfo = NetworkInfoImpl();

//   final ProductRepository productRepository = ProductRepositoryImpl(
//     localDataSource: productLocalDataSource,
//     remoteDataSource: productRemoteDataSource,
//     networkInfo: networkInfo,
//   );

//   runApp(MyApp(productRepository: productRepository));
// }
// class MyApp extends StatelessWidget {
//   final ProductRepository productRepository;

//   const MyApp({super.key, required this.productRepository});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Product Manager',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(productRepository: productRepository),
//         SearchProduct.routeName: (context) =>
//             SearchProduct(productRepository: productRepository),
//         DetailsPage.routeName: (context) =>
//             DetailsPage(productRepository: productRepository),
        
//       },
//     );
//   }
// }
