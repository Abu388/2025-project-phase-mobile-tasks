import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(5),
          width: 5,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFCCCCCC), //0xFF000000  0xFFCCCCCC
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // aligns children to the left
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'July 14, 2023',
                style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 8.0),
              ),
              SizedBox(height: 1.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello, ",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Color(0xFFAAAAAA),
                    ),
                  ),
                  Text(
                    "Yohannes",
                    style: TextStyle(
                      fontFamily: 'sora',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Container(
            // margin: EdgeInsets.only(right: 50.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notification_add),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50), // height of the bottom section
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                " Available Products",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                  height: 1.0,
                  color: Color(0xFF3E3E3E),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                style: ButtonStyle(),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          // Scrollable list
          ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return buildImageCard();
            },
          ),

          // Fixed button
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                // Your action
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3F51F3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//SizedBox(height: 10),

Widget buildImageCard() {
  return Column(
    children: [
      Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: Image.asset(
            'images/s2.jpg',
            width: 395,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(12, 8, 16, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Derby Leather",
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
            Text(
              "\$120",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0xFF3E3E3E),
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Men’s shoe",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 12,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0xFFAAAAAA),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.star, color: Colors.yellow),
                ),
                Text("\$(4.0)"),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class Expand extends StatelessWidget {
  final Widget child;

  const Expand({required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: child);
  }
}

// Padding(
//               padding: const EdgeInsets.all(5.0),

//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
                  
//                   Text(
//                     "Derby Leather Shoes",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 20,
//                       color: Color(0xFF3E3E3E),
//                     ),
//                   ),
//                   Text("\$ 120.00"),
//                 ],
//               ),
//             ),













// import 'package:flutter/material.dart';
// import 'package:hello_app/learn_flutter_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (BuildContext context) {
//                 return const LearnFlutterPage();
//               },
//             )
//           );
//         },
//         style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             foregroundColor: Colors.white,
          
//         ),
//         child: const Text('Learn flutter'),
//       ),
      
//     );
//   }
// }
