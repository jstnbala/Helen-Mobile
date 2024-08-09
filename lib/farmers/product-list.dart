// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:helen_app/farmers/addproduct.dart';

class ProductListFarmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFCA771A), // Header color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Adjust radius as needed
              bottomRight: Radius.circular(20.0), // Adjust radius as needed
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white, // Back button color
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "List of Products",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductPage()),
                  );
                },
                child: Image.asset(
                  'images/farmers/product-add.png', // Replace with actual image path
                  height: 100, // Adjust size as needed
                ),
              ),
            ),
            SizedBox(height: 20),
            ProductCard(
              productName: 'Sweet Potato',
              quantity: '50 kilos',
              price: '100.00',
            ),
            SizedBox(height: 20),
            ProductCard(
              productName: 'Carrots',
              quantity: '30 kilos',
              price: '60.00',
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String quantity;
  final String price;

  ProductCard({
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.photo,
              size: 120,
              color: Colors.grey, // Placeholder for the picture
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Quantity: $quantity',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: $price',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              color: Color(0xFFCA771A),
              onPressed: () {
                // Add edit functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}