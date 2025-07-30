import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class AddProductPage extends StatefulWidget {
  final ProductRepository productRepository;

  const AddProductPage({super.key, required this.productRepository});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  void handleAddProduct() {
    final newProduct = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      name: nameController.text,
      desc: descController.text,
      price: priceController.text,
      imagePath: imagePathController.text,
    );

    widget.productRepository.addProduct(newProduct);
    Navigator.pop(context); // Go back after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: imagePathController,
              decoration: const InputDecoration(labelText: 'Image Path'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleAddProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  
                ),
              ),
              child: const Text(
                'Add Product',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}











































// import 'package:flutter/material.dart';
// import '../../domain/repositories/product_repository.dart';
// import '../../domain/entities/product.dart'; // adjust if needed based on your folder structure

// class AddProductPage extends StatefulWidget {
//   static const routeName = '/addproduct';

//   final ProductRepository productRepository;

//   const AddProductPage({
//     super.key,
//     required this.productRepository,
//   });

//   @override
//   State<AddProductPage> createState() => _AddProductPageState();
// }

// class _AddProductPageState extends State<AddProductPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _imageController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _descController.dispose();
//     _imageController.dispose();
//     super.dispose();
//   }

//   void _saveProduct() async {
//     if (_formKey.currentState!.validate()) {
//       final newProduct = Product(
//         name: _nameController.text.trim(),
//         price: double.tryParse(_priceController.text.trim()) ?? 0.0,
//         description: _descController.text.trim(),
//          id: '', imageUrl: '',
//       );

//       await widget.productRepository.addProduct(newProduct);
//       Navigator.pop(context, true); // or pass back newProduct if needed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Product Name'),
//                 validator: (v) =>
//                     v == null || v.isEmpty ? 'Enter product name' : null,
//               ),
//               TextFormField(
//                 controller: _priceController,
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (v) =>
//                     v == null || v.isEmpty ? 'Enter price' : null,
//               ),
//               TextFormField(
//                 controller: _descController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               TextFormField(
//                 controller: _imageController,
//                 decoration: const InputDecoration(labelText: 'Image Path'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProduct,
//                 child: const Text('Add Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
