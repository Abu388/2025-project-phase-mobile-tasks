import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
// import your widgets here
import '../widgets/common_button.dart';
import 'add_product_page.dart';
import '../widgets/image_card.dart';  // if you have this for the image cards
import '../widgets/range_slider_widget.dart';
import 'add_product_page.dart';


class SearchProduct extends StatefulWidget {
  const SearchProduct({
    super.key,
    required this.productRepository,
  });

  final ProductRepository productRepository;

  static const routeName = '/search';

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _rangeValues = const RangeValues(20, 80);
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadProducts() async {
    final products = await widget.productRepository.getAllProducts();
    setState(() {
      _allProducts = products;
      _filteredProducts = products;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Search Product',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xFF3E3E3E),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 247, 247),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _filteredProducts.isEmpty
    ? ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          // Use your image cards (assuming imported from image_card.dart)
          buildImageCard(),
          const SizedBox(height: 20),
          buildImageCard2(),

          const SizedBox(height: 24),

          // Use your custom RangeSliderWidget correctly:
          RangeSliderWidget(
            start: _rangeValues.start,
            end: _rangeValues.end,
            onChanged: (values) {
              setState(() {
                _rangeValues = values;
              });
            },
          ),

          const SizedBox(height: 20),

          // Use your CommonButton correctly:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF3F51F3),
                padding: EdgeInsets.symmetric(horizontal: 183, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddProductPage(productRepository: widget.productRepository),
            ),
          );},
              child: Text('APPLY', style: TextStyle(color: Colors.white)),),
          ),
        ],
      )
    : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          final product = _filteredProducts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.network(
                product.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
            ),
          );
        },
      ),


    );
  }
}

























// import 'package:flutter/material.dart';
// import '../../domain/entities/product.dart';
// import '../../domain/repositories/product_repository.dart';

// class SearchProduct extends StatefulWidget {
//   const SearchProduct({
//     super.key,
//     required this.productRepository,
//   });

//   final ProductRepository productRepository;
  
//   static const routeName = '/search';

//   @override
//   State<SearchProduct> createState() => _SearchProductState();
// }

// class _SearchProductState extends State<SearchProduct> {
//   final TextEditingController _searchController = TextEditingController();
//   RangeValues _rangeValues = const RangeValues(20, 80);
//   List<Product> _allProducts = [];
//   List<Product> _filteredProducts = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts();
//     _searchController.addListener(_onSearchChanged);
//   }

//   Future<void> _loadProducts() async {
//     final products = await widget.productRepository.getAllProducts();
//     setState(() {
//       _allProducts = products;
//       _filteredProducts = products;
//     });
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredProducts = _allProducts.where((product) {
//         return product.name.toLowerCase().contains(query);
//       }).toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           'Search Product',
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w500,
//             fontSize: 20,
//             color: Color(0xFF3E3E3E),
//           ),
//         ),
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(50),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 248, 247, 247),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.black, width: 1.5),
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: _filteredProducts.isEmpty
//           ? ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 SizedBox(height: 20),
//                 buildImageCard(),
//                 SizedBox(height: 20),
//                 buildImageCard2(),
//                   Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: RangeSlider(
//                 values: _rangeValues,
//                 min: 0,
//                 max: 100,
//                 activeColor: Colors.blueAccent,
//                 inactiveColor: Colors.grey.shade300,
//                 onChanged: (RangeValues newValues) {
//                   setState(() {
//                     _rangeValues = newValues;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 20),

//             // ADD button
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0XFF3F51F3),
//                 padding: EdgeInsets.symmetric(horizontal: 183, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {},
//               child: Text('APPLY', style: TextStyle(color: Colors.white)),),

//               ],
//             )
//           : ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: _filteredProducts.length,
//               itemBuilder: (context, index) {
//                 final product = _filteredProducts[index];
//                 return Card(
//                   margin: EdgeInsets.only(bottom: 16),
//                   child: ListTile(
//                     leading: Image.network(
//                       product.imagePath,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(product.name),
//                     subtitle: Text('\$${product.price}'),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Widget buildImageCard() {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(50),
//             topRight: Radius.circular(50),
//           ),
//           child: Image.asset(
//             'images/s2.jpg',
//             width: double.infinity,
//             height: 300,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 8, 16, 1),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Derby Leather",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                   color: Color(0xFF3E3E3E),
//                 ),
//               ),
//               Text(
//                 "\$120",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Color(0xFF3E3E3E),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Men’s shoe",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                   color: Color(0xFFAAAAAA),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.yellow),
//                   Text('(4.0)'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildImageCard2() {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(50),
//             topRight: Radius.circular(50),
//           ),
//           child: Image.asset(
//             'images/s22.jpg',
//             width: double.infinity,
//             height: 300,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 8, 16, 1),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Category',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                   color: Color(0xFF000000),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 height: 57,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 248, 246, 246),
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 alignment: Alignment.centerLeft,
//                 child: const Text(''),
//               ),
//               SizedBox(height: 5),
//               Text(
//                 "Price",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                   color: Color.fromARGB(255, 87, 85, 85),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }





