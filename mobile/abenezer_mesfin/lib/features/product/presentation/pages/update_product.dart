import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;
  final void Function(Product updatedProduct) onUpdate;

  const UpdateProductPage({
    required this.product,
    required this.onUpdate,
    super.key,
  });

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController priceController;
  late TextEditingController imagePathController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descController = TextEditingController(text: widget.product.desc);
    priceController = TextEditingController(text: widget.product.price);
    imagePathController = TextEditingController(text: widget.product.imagePath);
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    imagePathController.dispose();
    super.dispose();
  }

  void handleUpdate() {
    final updated = Product(
      id: widget.product.id,
      name: nameController.text,
      desc: descController.text,
      price: priceController.text,
      imagePath: imagePathController.text,
    );
    widget.onUpdate(updated);
    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
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
              onPressed: handleUpdate,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}




























// import 'package:flutter/material.dart';
// import '../../domain/entities/product.dart';

// class UpdateProductPage extends StatefulWidget {
//   final Product product;
//   final void Function(Product updatedProduct) onUpdate;

//   const UpdateProductPage({
//     required this.product,
//     required this.onUpdate,
//     super.key,
//   });

//   @override
//   State<UpdateProductPage> createState() => _UpdateProductPageState();
// }

// class _UpdateProductPageState extends State<UpdateProductPage> {
//   late TextEditingController nameController;
//   late TextEditingController descController;
//   late TextEditingController priceController;
//   late TextEditingController imagePathController;

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.product.name);
//     descController = TextEditingController(text: widget.product.desc);
//     priceController = TextEditingController(text: widget.product.price);
//     imagePathController = TextEditingController(text: widget.product.imagePath);
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     descController.dispose();
//     priceController.dispose();
//     imagePathController.dispose();
//     super.dispose();
//   }

//   void handleUpdate() {
//     final updated = Product(
//       id: widget.product.id,
//       name: nameController.text,
//       desc: descController.text,
//       price: priceController.text,
//       imagePath: imagePathController.text,
//     );
//     widget.onUpdate(updated);
//     Navigator.pop(context); // Go back to details page
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Update Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
//             TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
//             TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price')),
//             TextField(controller: imagePathController, decoration: const InputDecoration(labelText: 'Image Path')),
//             const SizedBox(height: 20),
//             ElevatedButton(onPressed: handleUpdate, child: const Text('Save Changes')),
//           ],
//         ),
//       ),
//     );
//   }
// }
