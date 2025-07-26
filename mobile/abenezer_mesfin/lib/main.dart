import 'package:flutter/material.dart';
import 'package:hello_app/addProductPage.dart';
import 'package:hello_app/home_page.dart';
import 'package:hello_app/details_page.dart';
import 'package:hello_app/search_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        DetailsPage.routeName: (_) => const DetailsPage(),
        AddProductPage.routeName: (_) => const AddProductPage(),
        SearchProduct.routeName: (_) => const SearchProduct(),
      },
    );
  }
}
