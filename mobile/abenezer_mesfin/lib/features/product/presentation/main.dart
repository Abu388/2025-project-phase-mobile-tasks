import 'package:flutter/material.dart';

import '../data/datasources/product_local_data_source.dart';
import '../data/datasources/product_remote_data_source_impl.dart';  // <-- new impl
import '../data/network/network_info_impl.dart';                     // <-- new impl
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'pages/search_product.dart';

void main() {
  final productLocalDataSource = ProductLocalDataSource();
  final productRemoteDataSource = ProductRemoteDataSourceImpl();
  final networkInfo = NetworkInfoImpl(); // pass instance

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
