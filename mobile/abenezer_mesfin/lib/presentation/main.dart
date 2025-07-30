import 'package:flutter/material.dart';

import '../data/datasources/product_local_data_source.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'pages/search_product.dart';

void main() {
  final productLocalDataSource = ProductLocalDataSource();
  final ProductRepository productRepository =
      ProductRepositoryImpl(productLocalDataSource);

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
