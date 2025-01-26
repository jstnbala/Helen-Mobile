// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-product_details.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/filterscreens/newest_screen.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/filterscreens/popular_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:helen_app/src/services/fetch_org_api.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/search/searchScreen.dart';

class HomePageBuyer extends StatefulWidget {
  const HomePageBuyer({super.key});

  @override
  _HomePageBuyerState createState() => _HomePageBuyerState();
}

class _HomePageBuyerState extends State<HomePageBuyer> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = true; // New variable to track loading state

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await fetchVerifiedProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false; // Set loading to false once data is fetched
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Also set loading to false if there's an error
      });
      print('An error occurred: $e');
    }
  }

  double calculateAverageRating(List<Map<String, dynamic>> reviews) {
    if (reviews.isEmpty) return 0.0; // Return 0.0 if no reviews

    double totalRating =
        reviews.fold(0, (sum, review) => sum + (review['rating'] ?? 0));
    return totalRating / reviews.length;
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        final productName = (product['ProductName'] ?? '').toLowerCase();
        return productName.contains(query);
      }).toList();
    });
  }

  Future<List<dynamic>> fetchVerifiedProducts() async {
    List<String> organizations = await FetchOrgApi.fetchAllOrganizations();
    List<dynamic> allVerifiedProducts = [];

    for (String OrgName in organizations) {
      final url =
          'https://helen-server-lmp4.onrender.com/api/organizations/$OrgName/products';

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          print('Organization name $OrgName');
          final List<dynamic> responseData = jsonDecode(response.body);

          // Filter products to include only those with Verified status
          final verifiedProducts = responseData
              .where((product) => product['status'] == 'Verified')
              .map((product) => {
                    ...product,
                    'OrgName': OrgName // Add OrgName to each verified product
                  })
              .toList();

          allVerifiedProducts.addAll(verifiedProducts);
        } else {
          throw Exception('Failed to load products');
        }
      } catch (e) {
        print('An error occurred: $e');
        return [];
      }
    }

    return allVerifiedProducts;
  }

  String extractDecimalValue(dynamic priceData) {
    if (priceData is Map && priceData.containsKey(r'$numberDecimal')) {
      return priceData[r'$numberDecimal'].toString();
    }
    return priceData.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 253, 253, 253), // Set the background color to #f7f1ec
        body: RefreshIndicator(
            onRefresh: _fetchProducts,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      readOnly: true,
                      onTap: () {
                        // Navigate to SearchScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen(
                                    verifiedProductList:
                                        _filteredProducts, // Pass the verified product list here
                                  )),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Here...',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 135, 135, 135),
                          fontFamily: 'Poppins',
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFCA771A),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment:
                          Alignment.centerLeft, // Aligns the text to the left
                      child: Row(
                        children: [
                          const Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              fontWeight: FontWeight.bold, // Optional styling
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PopularScreen(
                                    verifiedProductList: _filteredProducts,
                                  ), // Replace with your screen
                                ),
                              );
                            },
                            child: const Text(
                              'View All >',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                                color: Color.fromARGB(255, 34, 34, 34),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 235,
                      child: _isLoading
                          ? Skeletonizer(
                              child: ListView.builder(
                                scrollDirection:
                                    Axis.horizontal, // Scroll horizontally
                                itemCount:
                                    3, // Number of rows (adjust as needed)
                                itemBuilder: (context, rowIndex) {
                                  return Row(
                                    children: List.generate(
                                      3, // Number of items per row
                                      (index) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5, // Adjust item width
                                          margin: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const SizedBox(
                                              height:
                                                  250), // Placeholder height
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : _filteredProducts.isEmpty
                              ? const Center(
                                  child: Text(
                                      'No available agricultural products found.'))
                              : ListView.builder(
                                  scrollDirection:
                                      Axis.horizontal, // Scroll horizontally
                                  itemCount: (_filteredProducts.length / 3)
                                      .ceil(), // Number of rows
                                  itemBuilder: (context, rowIndex) {
                                    return Row(
                                      children: List.generate(
                                        3, // Number of items per row
                                        (index) {
                                          final productIndex =
                                              rowIndex * 3 + index;
                                          if (productIndex >=
                                              _filteredProducts.length) {
                                            return const SizedBox.shrink();
                                          }

                                          final product =
                                              _filteredProducts[productIndex];
                                          final productPic =
                                              product['ProductPic'];
                                          final productName =
                                              product['ProductName'] ??
                                                  'Unnamed Product';
                                          final quantity =
                                              '${product['Inventory'] ?? 0} ${product['Unit'] ?? ''}';
                                          final price = extractDecimalValue(
                                              product['Price']);
                                          final productDetails =
                                              product['ProductDetails'] ??
                                                  'No details available';
                                          final farmerName =
                                              product['FarmerName'] ??
                                                  'Unknown Farmer';
                                          final orgname = product['OrgName'] ??
                                              'Unknown Organization';
                                          final productDate =
                                              product['createdAt'];
                                          DateTime parsedDate = DateTime.parse(
                                              productDate); // If it's a string, parse it
                                          String formattedDate =
                                              DateFormat('MM/dd/yyyy')
                                                  .format(parsedDate);

                                          final averageRating =
                                              calculateAverageRating(List<
                                                      Map<String,
                                                          dynamic>>.from(
                                                  product['Reviews'] ?? []));

                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.0, // Adjust item width
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,

                                            margin: const EdgeInsets.all(5.0),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailsClass(
                                                        productPic: productPic,
                                                        productName:
                                                            productName,
                                                        quantity: quantity,
                                                        price: price,
                                                        productDetails:
                                                            productDetails,
                                                        farmerName: farmerName,
                                                        organization: orgname,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      productPic.isNotEmpty
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                productPic,
                                                                width: double
                                                                    .infinity,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : const Icon(
                                                              Icons.image,
                                                              size: 120,
                                                              color:
                                                                  Colors.grey),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        productName,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFCA771A),
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  '₱', // Peso symbol
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xFFCA771A)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                            price,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFFCA771A),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                              size: 16.0),
                                                          Text(
                                                            averageRating
                                                                .toStringAsFixed(
                                                                    1), // Display with 1 decimal place
                                                          ),
                                                          Text(' | 54 sold')
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                          formattedDate,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    134,
                                                                    134,
                                                                    134),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment:
                          Alignment.centerLeft, // Aligns the text to the left
                      child: Row(
                        children: [
                          const Text(
                            'Newest',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              fontWeight: FontWeight.bold, // Optional styling
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewestScreen(
                                      verifiedProductList:
                                          _filteredProducts), // Replace with your screen
                                ),
                              );
                            },
                            child: const Text(
                              'View All >',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                                color: Color.fromARGB(255, 34, 34, 34),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 235,
                      child: _isLoading
                          ? Skeletonizer(
                              child: ListView.builder(
                                scrollDirection:
                                    Axis.horizontal, // Scroll horizontally
                                itemCount:
                                    3, // Number of rows (adjust as needed)
                                itemBuilder: (context, rowIndex) {
                                  return Row(
                                    children: List.generate(
                                      3, // Number of items per row
                                      (index) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5, // Adjust item width
                                          margin: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const SizedBox(
                                              height:
                                                  250), // Placeholder height
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : _filteredProducts.isEmpty
                              ? const Center(
                                  child: Text(
                                      'No available agricultural products found.'))
                              : ListView.builder(
                                  scrollDirection:
                                      Axis.horizontal, // Scroll horizontally
                                  itemCount: (_filteredProducts.length / 3)
                                      .ceil(), // Number of rows
                                  itemBuilder: (context, rowIndex) {
                                    return Row(
                                      children: List.generate(
                                        3, // Number of items per row
                                        (index) {
                                          final productIndex =
                                              rowIndex * 3 + index;
                                          if (productIndex >=
                                              _filteredProducts.length) {
                                            return const SizedBox.shrink();
                                          }

                                          final product =
                                              _filteredProducts[productIndex];
                                          final productPic =
                                              product['ProductPic'];
                                          final productName =
                                              product['ProductName'] ??
                                                  'Unnamed Product';
                                          final quantity =
                                              '${product['Inventory'] ?? 0} ${product['Unit'] ?? ''}';
                                          final price = extractDecimalValue(
                                              product['Price']);
                                          final productDetails =
                                              product['ProductDetails'] ??
                                                  'No details available';
                                          final farmerName =
                                              product['FarmerName'] ??
                                                  'Unknown Farmer';
                                          final orgname = product['OrgName'] ??
                                              'Unknown Organization';
                                          final productDate =
                                              product['createdAt'];
                                          DateTime parsedDate = DateTime.parse(
                                              productDate); // If it's a string, parse it
                                          String formattedDate =
                                              DateFormat('MM/dd/yyyy')
                                                  .format(parsedDate);

                                          final averageRating =
                                              calculateAverageRating(List<
                                                      Map<String,
                                                          dynamic>>.from(
                                                  product['Reviews'] ?? []));

                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.0, // Adjust item width
                                            height: 500, // Adjust item width

                                            margin: const EdgeInsets.all(5.0),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailsClass(
                                                        productPic: productPic,
                                                        productName:
                                                            productName,
                                                        quantity: quantity,
                                                        price: price,
                                                        productDetails:
                                                            productDetails,
                                                        farmerName: farmerName,
                                                        organization: orgname,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      productPic.isNotEmpty
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                productPic,
                                                                width: double
                                                                    .infinity,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : const Icon(
                                                              Icons.image,
                                                              size: 120,
                                                              color:
                                                                  Colors.grey),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        productName,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFCA771A),
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  '₱', // Peso symbol
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xFFCA771A)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                            price,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFFCA771A),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                              size: 16.0),
                                                          Text(
                                                            averageRating
                                                                .toStringAsFixed(
                                                                    1), // Display with 1 decimal place
                                                          ),
                                                          Text(' | 54 sold')
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                          formattedDate,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    134,
                                                                    134,
                                                                    134),
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
