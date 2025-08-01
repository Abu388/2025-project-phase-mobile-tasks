// image_card.dart
import 'package:flutter/material.dart';

Widget buildImageCard() {
  return Column(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: Image.asset(
          'images/s2.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 16, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Derby Leather",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFF3E3E3E),
              ),
            ),
            Text(
              "\$120",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF3E3E3E),
              ),
            ),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Men’s shoe",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFFAAAAAA),
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text('(4.0)'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildImageCard2() {
  return Column(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: Image.asset(
          'images/s22.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 16, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 57,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 246, 246),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: const Text(''),
            ),
            const SizedBox(height: 5),
            const Text(
              "Price",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color.fromARGB(255, 87, 85, 85),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
