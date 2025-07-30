import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'add_product_page.dart';
import 'details_page.dart';
import 'search_product.dart';

class HomePage extends StatefulWidget {
  final ProductRepository productRepository;

  const HomePage({super.key, required this.productRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<Product> data;
  List<Product> data = []; // Default empty list

  @override
  void initState() {
    super.initState();
    _loadProducts(); // call async method separately
  }

  Future<void> _loadProducts() async {
    final result = await widget.productRepository.getAllProducts();

    // ignore: unnecessary_type_check
    if (result is List<Product>) {
      setState(() {
        data = result;
      });
    } else {
      setState(() {
        data = result.map((e) => e).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Hello, ',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFFAAAAAA),
                    ),
                  ),
                  Text(
                    'Yohannes',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Available Products',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchProduct.routeName);
                },
                icon: const Icon(Icons.search),
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
                  arguments: item, // <-- fixed here
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
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        item.imagePath,
                        width: 400,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
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
                              item.price,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddProductPage(productRepository: widget.productRepository),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
