import 'package:flutter/material.dart';
import 'package:hello_app/addProductPage.dart';
import 'package:hello_app/details_page.dart';
import 'package:hello_app/search_product.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> data = [
    {
      'name': 'Item 1',
      'image': 'images/s2.jpg',
      'desc': 'This is item 1',
      'price': '\$30',
    },
    {
      'name': 'Item 2',
      'image': 'images/s22.jpg',
      'desc': 'This is item 2',
      'price': '\$35',
    },
    {
      'name': 'Item 3',
      'image': 'images/s23.jpg',
      'desc': 'This is item 3',
      'price': '\$20',
    },
  ];

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
                onPressed: () {
                  Navigator.pushNamed(context, SearchProduct.routeName);
                },
                icon: Icon(Icons.search),
                style: ButtonStyle(),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: data.map((item) {
            return InkWell(
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: item,
                );
                if (result != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(result.toString())));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      item['image']!,
                      width: 400,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['name']!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                            color: Color.fromARGB(255, 27, 22, 22),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            Text(
                              item['price']!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color.fromARGB(255, 71, 71, 71),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      "Man's shoe",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xFF313131),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3F51F3),

        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AddProductPage.routeName,
          );

          if (result is Map<String, String>) {
            setState(() => data.add(result));
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



