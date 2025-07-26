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

































// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class DetailsPage extends StatelessWidget {
//   const DetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final numberStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           SizedBox(height: 20),
//           Container(child: buildImageCard()),
//           SizedBox(height: 20),
//           Container(
//             padding: EdgeInsets.only(left: 16.0),
//             child: Text(
//               "Size:",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 20,
//                 height: 1.0,
//                 letterSpacing: 0.0,
//                 color: Color(0xFF3E3E3E),
//               ),
//             ),
//           ),

//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text("39", style: numberStyle),
//               Text("40", style: numberStyle),
//               Container(
//                 width: 50,
//                 height: 50,

//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: Color(0xFF3F51F3),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),

//                 child: Center(
//                   child: Text(
//                     "41",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),

//               Text("42", style: numberStyle),
//               Text("43", style: numberStyle),

//               Text("44", style: numberStyle),
//             ],
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: EdgeInsets.only(left: 16, right: 10),
//             child: Text(
//               "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 14,
//                 height: 1.5,
//                 letterSpacing: 0.0,
//                 color: Color(0xFF666666),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: ElevatedButton(style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0), ),
//                       side: BorderSide(
//                         color: Colors.red,
//                         width: 1.5,
//                       ),
//                     ),onPressed: () {}, child: Text("DELETE", style: TextStyle(color: Colors.red))),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 16.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0XFF3F51F3),
//                     shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0), ),
                    
//                   ),
                  
//                   onPressed: () {},
//                   child: Text(' UPDATE', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget buildImageCard() {
//   return Column(
//     children: [
//       Container(
//         child: Stack(children: [ ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(50),
//             topRight: Radius.circular(50),
//           ),
//           child: Image.asset(
//             'images/s2.jpg',
//             width: 395,
//             height: 300,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned(child: Padding(
//           padding: const EdgeInsets.only(top: 16.0,left: 16),
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18),
              
//             ),
            
//             child: Icon(Icons.arrow_back ,color: Colors.blue,)
//             ),
//         ))
//         ]
//         )
//       ),
//       Container(
//         padding: EdgeInsets.fromLTRB(12, 8, 16, 1),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Men’s shoe",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w400,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 12,
//                 height: 1.0,
//                 letterSpacing: 0.0,
//                 color: Color(0xFFAAAAAA),
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.star, color: Colors.yellow),
//                 ),
//                 Text(
//                   "\$(4.0)",
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 12,
//                     height: 1.0,
//                     letterSpacing: 0.0,
//                     color: Color(0xFFAAAAAA),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(right: 8.0), // or any values you need
//               child: Text(
//                 "Derby Leather",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 20,
//                   height: 1.0,
//                   letterSpacing: 0.0,
//                   color: Color(0xFF3E3E3E),
//                 ),
//               ),
//             ),

//             Text(
//               "\$120",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 14,
//                 height: 1.0,
//                 letterSpacing: 0.0,
//                 color: Color(0xFF3E3E3E),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
