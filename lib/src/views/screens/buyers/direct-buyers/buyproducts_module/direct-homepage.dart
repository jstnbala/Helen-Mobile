// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-product_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:helen_app/src/services/fetch_org_api.dart';

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
    List <String> organizations = await FetchOrgApi.fetchAllOrganizations();
    List<dynamic> allVerifiedProducts = [];

    for (String OrgName in organizations) {
      final url = 'https://helen-server-lmp4.onrender.com/api/organizations/$OrgName/products';


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
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Color(0xFFCA771A)),
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
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFCA771A),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFFCA771A),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _isLoading
                ? Skeletonizer(
                    // Adjust the height and width as needed
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 4, // Number of skeletons to show
                      itemBuilder: (context, index) {
                        return Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    ),
                  )
                : _filteredProducts.isEmpty
                    ? const Center(child: Text('No available agricultural products found.'))
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          final productPic = product['ProductPic'];
                          final productName = product['ProductName'] ?? 'Unnamed Product';
                          final quantity = '${product['Inventory'] ?? 0} ${product['Unit'] ?? ''}';
                          final price = extractDecimalValue(product['Price']);
                          final productDetails = product['ProductDetails'] ?? 'No details available';
                          final farmerName = product['FarmerName'] ?? 'Unknown Farmer';
                          final orgname = product['OrgName'] ?? 'Unknown Organization';

                          return SizedBox(
                            height: 250,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsClass(
                                        productPic: productPic,
                                        productName: productName,
                                        quantity: quantity,
                                        price: price,
                                        productDetails: productDetails,
                                        farmerName: farmerName,
                                        organization: orgname,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      productPic.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network(
                                                productPic,
                                                width: double.infinity,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Icon(Icons.image, size: 120, color: Colors.grey),
                                      const SizedBox(height: 10),
                                      Text(
                                        productName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Unit: $quantity',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Price: PHP $price',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ),
              ],
            ),
          ),
  ); 
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

