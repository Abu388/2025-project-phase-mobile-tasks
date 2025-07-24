import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Color(0XFF3F51F3)),
        title: Center(
          child: Text(
            'Add Product',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              height: 1.0,
              letterSpacing: 0.0,
              color: Color(0xFF3E3E3E),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 190,
                  width: 390,
                  color: Color.fromARGB(255, 216, 215, 215),
                ),
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, //
                      children: [
                        Icon(Icons.add_photo_alternate_outlined, size: 50),

                        Text("uppload image"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("name"),
                ),
              ),

              Container(
                height: 57,
                width: 390,
                color: Color.fromARGB(255, 216, 215, 215),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("category"),
                ),
              ),

              Container(
                height: 57,
                width: 390,
                color: Color.fromARGB(255, 216, 215, 215),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("price"),
                ),
              ),

              Container(
                height: 57,
                width: 390,
                color: Color.fromARGB(255, 216, 215, 215),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // pushes icon to the right
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16.0,
                      ), // optional spacing from right edge
                      child: Icon(Icons.attach_money),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("description"),
                ),
              ),

              Container(
                height: 190,
                width: 390,
                color: Color.fromARGB(255, 216, 215, 215),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF3F51F3),
                  padding: EdgeInsets.symmetric(horizontal: 183, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text('ADD', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 175, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
                onPressed: () {},
                child: Text('DELETE', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// body: Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: Column(
//     children: [
//       TextField(
//         decoration: InputDecoration(
//           labelText: 'Enter your name',
//           border: OutlineInputBorder(),
//         ),
//       ),
//     ],
//   ),
// ),
