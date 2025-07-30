import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'update_product.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/details';

  final ProductRepository productRepository;

  const DetailsPage({super.key, required this.productRepository});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedSize = -1;
  final List<String> sizes = ['39', '40', '41', '42', '43', '44'];
  late Product product;

  Widget _buildImage(String? path) {
    if (path == null || path.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Icon(Icons.image_not_supported)),
      );
    }

    final isAsset = !path.startsWith('/') && !path.startsWith('file://');
    return isAsset
        ? Image.asset(
            path,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(path),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Product) {
      product = arg;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('No product data provided')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(product.imagePath),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(product.price, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              const Text(
                'Size:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFF3E3E3E),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: sizes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final size = entry.value;
                  final isSelected = selectedSize == index;

                  return GestureDetector(
                    onTap: () => setState(() => selectedSize = index),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected
                            ? const Color(0xFF3F51F3)
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                product.desc,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Color(0xFF3E3E3E),
                ),
              ),
              const SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                            'Are you sure you want to delete this product?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await widget.productRepository.deleteProduct(
                          product.id,
                        );
                        Navigator.pop(context); // Go back after deletion
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        // Padding inside the button
                        horizontal: 43,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        // Rounded box shape
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                        // 👈 red border here
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateProductPage(
                            product: product,
                            onUpdate: (updatedProduct) {
                              widget.productRepository.updateProduct(
                                updatedProduct,
                              );
                              setState(() {
                                product = updatedProduct;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        // Padding inside the button
                        horizontal: 43,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        // Rounded box shape
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: selectedSize != -1
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      "You bought ${product.name} in size ${sizes[selectedSize]} for ${product.price}.",
                    );
                  },
                  child: Text("Buy ${product.price}"),
                ),
              ),
            )
          : null,
    );
  }
}









































// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../../domain/entities/product.dart';
// import '../../domain/repositories/product_repository.dart'; // make sure this is the correct path

// class DetailsPage extends StatefulWidget {
//   static const routeName = '/details';
//   const DetailsPage({super.key, required ProductRepository productRepository});

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   int selectedSize = -1;
//   final List<String> sizes = ['39', '40', '41', '42', '43', '44'];

//   Widget _buildImage(String? path) {
//     if (path == null || path.isEmpty) {
//       return const SizedBox(
//         height: 300,
//         child: Center(child: Icon(Icons.image_not_supported)),
//       );
//     }
//     final isAsset = !path.startsWith('/') && !path.startsWith('file://');
//     return isAsset
//         ? Image.asset(
//             path,
//             width: double.infinity,
//             height: 300,
//             fit: BoxFit.cover,
//           )
//         : Image.file(
//             File(path),
//             width: double.infinity,
//             height: 300,
//             fit: BoxFit.cover,
//           );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = ModalRoute.of(context)?.settings.arguments as Product?;

//     if (product == null) {
//       return const Scaffold(
//         body: Center(child: Text('No product data provided')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text(product.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildImage(product.imagePath),
//             const SizedBox(height: 16),
//             Text(
//               product.name,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text('${product.price}', style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 8),
//             Text(product.desc),
//             const SizedBox(height: 20),
//             const Text(
//               "Size:",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//                 color: Color(0xFF3E3E3E),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: sizes.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final size = entry.value;
//                 final isSelected = selectedSize == index;

//                 return GestureDetector(
//                   onTap: () => setState(() => selectedSize = index),
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: isSelected
//                           ? const Color(0xFF3F51F3)
//                           : Colors.transparent,
//                       border: Border.all(color: Colors.grey),
//                       boxShadow: isSelected
//                           ? [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ]
//                           : [],
//                     ),
//                     child: Center(
//                       child: Text(
//                         size,
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               product.desc,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//                 color: Color(0xFF3E3E3E),
//               ),
//             ),
            
//           ],
//         ),
//       ),
//       bottomNavigationBar: selectedSize != -1
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(
//                       context,
//                       "You bought ${product.name} in size ${sizes[selectedSize]} for ${product.price}.",
//                     );
//                   },
//                   child: Text("Buy ${product.price}"),
//                 ),
//               ),
//             )
//           : null,
//     );
//   }
// }
