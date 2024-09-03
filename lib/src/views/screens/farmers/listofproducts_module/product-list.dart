// ignore_for_file: file_names, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/addproducts_module/addproduct.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ProductListFarmer extends StatelessWidget {
  const ProductListFarmer({super.key});

Future<List<dynamic>> fetchProducts() async {
  const storage = FlutterSecureStorage();
  final orgname = await storage.read(key: 'Organization');
  final fullName = await storage.read(key: 'FullName');

  if (orgname == null || fullName == null) {
    print('Organization name or Full Name is missing');
    return [];
  }

  print('Full Name: $fullName');
  final url = 'https://helen-server-lmp4.onrender.com/api/organizations/$orgname/products';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      // Filter products based on the fullName
      final filteredProducts = responseData.where((product) {
        final productFarmerName = product['FarmerName'];
        return productFarmerName != null && productFarmerName.toString().trim().toLowerCase() == fullName.toLowerCase();
      }).toList();

      return filteredProducts;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('An error occurred: $e');
    return [];
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFCA771A),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "My List of Products",
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
        child: FutureBuilder<List<dynamic>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.'));
            } else {
              final products = snapshot.data!;
              return Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddProductPage()),
                        );
                      },
                      child: Image.asset(
                        'images/farmers/product-add.png',
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final price = product['Price']?? 'no  price';
                        final status = product['status'] ?? 'Unknown';  // Handle potential null status
                        final
                        // Handle price formatting
                        String formattedPrice;
                        if (price is Map) {
                          formattedPrice = price.values.isNotEmpty ? price.values.first.toString() : '0.00';
                        } else {
                          formattedPrice = price?.toString() ?? '0.00';
                        }

                        // Handle potential null Inventory and Unit
                        final inventory = product['Inventory'] ?? 0;
                        final unit = product['Unit'] ?? '';
                        final quantity = '$inventory $unit'; // Concatenate Inventory and Unit safely

                        // Safely handle productPic
                        final productPic = product['ProductPic'] ?? '';  
                        print('productPIc ${product[index]}');// Handle potential null ProductPic
                        print('productPIc $productPic');
                        print('price $price');
                        print('status $status');
                        print('formatted $formattedPrice');
                         print('quantity $quantity');
                        // Create and return ProductCard 
                        return ProductCard(
                          productName: product['ProductName'] ?? 'Unnamed Product',  // Handle potential null productName
                          quantity: quantity,
                          price: formattedPrice,
                          status: status,
                          productPic: productPic,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String quantity;
  final String price;
  final String status;
  final String productPic;

  const ProductCard({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.status,
    required this.productPic,
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
            productPic.isNotEmpty ? CachedNetworkImage(
                imageUrl: productPic,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.photo,
                  size: 120,
                  color: Colors.grey,
                ),
              )
            : const Icon(
                Icons.photo,
                size: 120,
                color: Colors.grey,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quantity: $quantity',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: PHP $price',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCA771A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
