// import 'package:flutter/material.dart';

// import '../../domain/repositories/product_repository.dart';

// class DeleteProductPage extends StatelessWidget {
//   static const routeName = '/delete';

//   const DeleteProductPage({super.key, required ProductRepository productRepository});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Delete Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Are you sure you want to delete this product?',
//                 style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context, true), // confirmed delete
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text('Delete'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context, false), // cancel
//                   child: const Text('Cancel'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
