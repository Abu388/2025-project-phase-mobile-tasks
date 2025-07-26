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



// import 'package:flutter/material.dart';
// import 'package:hello_app/Details_Page.dart';
// import 'package:hello_app/addProductPage.dart';
// import 'package:hello_app/add_product.dart';
// import 'package:hello_app/home_page.dart';
// import 'package:hello_app/search_product.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const VisiblePage(),
      
//     );
//   }
// }

// class VisiblePage extends StatefulWidget {
//   const VisiblePage({super.key});

//   @override
//   State<VisiblePage> createState() => _VisiblePageState();
// }

// class _VisiblePageState extends State<VisiblePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const HomePage();
//   }
// }
