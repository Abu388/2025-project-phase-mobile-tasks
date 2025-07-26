import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});
  static const routeName = '/search';
  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  RangeValues _rangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
        title: Text(
          'Search Product',
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
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            50,
          ), // height must match your Container
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 247, 247),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("Leather",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Color(0xFF666666),
                          ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.arrow_forward,
                            
                            size: 18,
                            color: Color(0xFF3F51F3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(right: 15),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF3F51F3),
                  borderRadius: BorderRadius.circular(5),
                ),

                child: Center(
                  child: Icon(
                    Icons.line_weight_sharp,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            buildImageCard(),
            SizedBox(height: 20),
            buildImageCard2(),
            SizedBox(height: 20),

            // ✅ RangeSlider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: RangeSlider(
                values: _rangeValues,
                min: 0,
                max: 100,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey.shade300,
                onChanged: (RangeValues newValues) {
                  setState(() {
                    _rangeValues = newValues;
                  });
                },
              ),
            ),

            SizedBox(height: 20),

            // ADD button
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
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

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

  Widget buildImageCard2() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: Image.asset(
            'images/s22.jpg',
            width: 395,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 16, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 57,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 246, 246),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                child: Text(""),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
