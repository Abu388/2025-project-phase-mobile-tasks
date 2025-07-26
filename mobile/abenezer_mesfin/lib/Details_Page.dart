import 'dart:io';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedSize = -1; // -1 = nothing picked
  final List<String> sizes = ["39", "40", "41", "42", "43", "44"];

  Widget _buildImage(String? path) {
    if (path == null || path.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Icon(Icons.image_not_supported)),
      );
    }
    final isAsset = !path.startsWith('/') && !path.startsWith('file://');
    return isAsset
        ? Image.asset(path, width: double.infinity, height: 300, fit: BoxFit.cover)
        : Image.file(File(path), width: double.infinity, height: 300, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String?>? item =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;

    if (item == null) {
      return const Scaffold(body: Center(child: Text('No item data provided')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(item['name'] ?? 'Details')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(item['image']),
            const SizedBox(height: 16),
            Text(item['name'] ?? '',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item['price'] ?? '', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text(item['desc'] ?? ''),
            const SizedBox(height: 20),
            const Text(
              "Size:",
              style: TextStyle(
                fontFamily: 'Poppins',
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
                      color: isSelected ? const Color(0xFF3F51F3) : Colors.transparent,
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
          ],
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
                      "You bought ${item['name']} in size ${sizes[selectedSize]} for ${item['price']}.",
                    );
                  },
                  child: Text("Buy ${item['price'] ?? ''}"),
                ),
              ),
            )
          : null,
    );
  }
}

















