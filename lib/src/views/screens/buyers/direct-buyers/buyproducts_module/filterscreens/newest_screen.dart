// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-product_details.dart';


class NewestScreen extends StatefulWidget {
    final List<dynamic>
      verifiedProductList; // Use a List to pass the verified product
  const NewestScreen(
       {
      Key? key, 
      required this.verifiedProductList, 
      }): super(key: key);

  @override
  _NewestScreenState createState() => _NewestScreenState();
}

class _NewestScreenState extends State<NewestScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> _filteredProducts;

  
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
      _products = widget.verifiedProductList;
          _filteredProducts = _products; // Initialize filtered list

    _searchController.addListener(_filterProducts);
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
              ),
              const Text(
                'Newest',
                style: TextStyle(
                  fontSize: 22, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Optional styling
                ),
              ),
            ],
          ),
          Expanded(
            child:  _filteredProducts.isEmpty
                    ? const Center(
                        child: Text('No available agricultural products found.'),
                      )
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
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
                            height: 250, // Fixed height for the card
                            child: Card(
                              elevation: 2,
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
                                                height: 120, // Height for the image
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
                                        'Quantity: $quantity',
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


}