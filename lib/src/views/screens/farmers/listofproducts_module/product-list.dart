import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/addproducts_module/addproduct.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/views/screens/farmers/listofproducts_module/product_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ProductListFarmer extends StatefulWidget {
  const ProductListFarmer({super.key});

  @override
  State<ProductListFarmer> createState() => _ProductListFarmerState();
}

class _ProductListFarmerState extends State<ProductListFarmer> {
  Future<List<dynamic>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = fetchProducts();
    });
    await _productsFuture; // Wait for the fetch to complete before finishing the refresh
  }

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
      child: AppBar(
        backgroundColor: const Color(0xFFCA771A),
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
    body: Stack(
      children: [
        // Upper half background with rounded corners
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            color: Color(0xFFCA771A),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        // Main content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add Product Button
              
              
              // Row of Data Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: buildDataCard(0, 'Total Products'),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: buildDataCard(0, 'Low Stock'),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: buildDataCard(0, 'Out of Stock'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
     Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Add Product Button
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ),
        );
      },
      child: Image.asset(
        'images/farmers/product-add.png',
        height: 70,
      ),
    ),
    // Filter Icon
    IconButton(
      onPressed: () {
        // Handle filter action
        showFilterOptions(context);
      },
      icon: const Icon(
        Icons.filter_list,
        size: 40,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  ],
),

                            const SizedBox(height: 20),

              // Product List
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    } else {
                      final products = snapshot.data!;
                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final price = product['Price'] ?? 'no price';
                          final status = product['status'] ?? 'Unknown';
                          String formattedPrice;
                          if (price is Map) {
                            formattedPrice = price.values.isNotEmpty
                                ? price.values.first.toString()
                                : '0.00';
                          } else {
                            formattedPrice = price?.toString() ?? '0.00';
                          }
                          final inventory = product['Inventory'] ?? 0;
                          final unit = product['Unit'] ?? '';
                          final quantity = '$inventory $unit';
                          final productPic = product['ProductPic'] ?? '';
                          final productDetails = product['ProductDetails'] ?? '';

                          return ProductCard(
                            productName: product['ProductName'] ?? 'Unnamed Product',
                            quantity: quantity,
                            price: formattedPrice,
                            status: status,
                            productPic: productPic,
                            productDetails: productDetails,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
void showFilterOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Filter by Price'),
              onTap: () {
                // Handle price filter
              },
            ),
            ListTile(
              title: const Text('Filter by Stock'),
              onTap: () {
                // Handle stock filter
              },
            ),
            ListTile(
              title: const Text('Filter by Rating'),
              onTap: () {
                // Handle rating filter
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildDataCard(int number, String value) {
  return AspectRatio(
    aspectRatio: 1, // 1:1 aspect ratio
    child: Card(
      color: Colors.white,
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            number.toString(), // Display number
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24.0, // Bigger font size for the number
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            textAlign: TextAlign.center, // Center text
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
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
    final String status;
    final String productPic;
    final String productDetails;

    const ProductCard({
      super.key,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.status,
      required this.productPic,
      required this.productDetails,
    });

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FarmerProductDetail(
                productName: productName,
                quantity: quantity,
                price: price,
                status: status,
                productPic: productPic,
                productDetails: productDetails,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPic.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: productPic,
                        width: 120,
                        height: 100,
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
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stock: $quantity',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromARGB(255, 133, 133, 133),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'P $price',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }