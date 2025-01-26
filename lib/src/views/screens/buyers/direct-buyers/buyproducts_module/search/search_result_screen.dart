// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-product_details.dart';
import 'package:intl/intl.dart';

class SearchResultScreen extends StatefulWidget {
  final List<dynamic>
      verifiedProductList; // Use a List to pass the verified product
  final String initialValue;

  const SearchResultScreen(
      {
      Key? key, 
      required this.verifiedProductList, 
      required this.initialValue
      }): super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  late List<dynamic> _products; // Initialize dynamically based on widget data
  late List<dynamic> _filteredProducts;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _products = widget.verifiedProductList;
    _filteredProducts = _products; // Initialize filtered list
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void sortProducts() {
    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      switch (selectedIndex) {
        case 0: // Relevance
          _filteredProducts.sort((a, b) {
            final searchValue = widget.initialValue.toLowerCase();
            final aMatch =
                a['ProductName']?.toLowerCase().contains(searchValue) ?? false;
            final bMatch =
                b['ProductName']?.toLowerCase().contains(searchValue) ?? false;
            if (aMatch && !bMatch) return -1;
            if (!aMatch && bMatch) return 1;
            return 0;
          });
          break;
        case 1: // Popularity
          _filteredProducts.sort((a, b) {
            final averageRatingA = calculateAverageRating(
                List<Map<String, dynamic>>.from(a['Reviews'] ?? []));
            final averageRatingB = calculateAverageRating(
                List<Map<String, dynamic>>.from(b['Reviews'] ?? []));
            return averageRatingB.compareTo(averageRatingA); // Descending order
          });
          break;
        case 2: // Latest
          _filteredProducts.sort((a, b) {
            final aDate =
                DateTime.tryParse(a['createdAt'] ?? '') ?? DateTime(1900);
            final bDate =
                DateTime.tryParse(b['createdAt'] ?? '') ?? DateTime(1900);
            return bDate.compareTo(aDate); // Descending order
          });
          break;
        default:
          break;
      }
    });
  }

  double calculateAverageRating(List<Map<String, dynamic>> reviews) {
    if (reviews.isEmpty) return 0.0; // Return 0.0 if no reviews

    double totalRating =
        reviews.fold(0, (sum, review) => sum + (review['rating'] ?? 0));
    return totalRating / reviews.length;
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
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start (left)
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to the previous screen
                    },
                  ),
                  Expanded(
                    // Ensures TextField expands to fill available space
                    child: TextField(
                        readOnly: true,
                        onTap: () {
                          // Navigate to SearchScreen
                          Navigator.pop(
                            context,
                            widget.initialValue,
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
                        controller: TextEditingController(
                          text: widget.initialValue,
                        )),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.filter_list, color: Color(0xFFCA771A)),
                    iconSize: 32, // Adjust this value to make the icon bigger

                    onPressed: () {
                      _openRightSideModal(context); // Open filter side panel
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      sortProducts();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 16),
                          child: Text(
                            'Relevance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 0
                                  ? const Color(0xFFCA771A)
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (selectedIndex == 0)
                          Container(
                            height: 4.0,
                            color: const Color(0xFFCA771A),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      sortProducts();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 16),
                          child: Text(
                            'Popular',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 1
                                  ? const Color(0xFFCA771A)
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (selectedIndex == 1)
                          Container(
                            height: 4.0,
                            color: const Color(0xFFCA771A),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      sortProducts();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 16),
                          child: Text(
                            'Latest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 2
                                  ? const Color(0xFFCA771A)
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (selectedIndex == 2)
                          Container(
                            height: 4.0,
                            color: const Color(0xFFCA771A),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator while data is being fetched
                  : _filteredProducts.isEmpty
                      ? const Center(
                          child:
                              Text('No available agricultural products found.'),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            final productPic = product['ProductPic'];
                            final productName =
                                product['ProductName'] ?? 'Unnamed Product';
                            final quantity =
                                '${product['Inventory'] ?? 0} ${product['Unit'] ?? ''}';
                            final price = extractDecimalValue(product['Price']);
                            final productDetails = product['ProductDetails'] ??
                                'No details available';
                            final farmerName =
                                product['FarmerName'] ?? 'Unknown Farmer';
                            final orgname =
                                product['OrgName'] ?? 'Unknown Organization';
                            final productDate = product['createdAt'];
                            DateTime parsedDate = DateTime.parse(
                                productDate); // If it's a string, parse it

// Format the date
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(parsedDate);

                            final averageRating = calculateAverageRating(
                                List<Map<String, dynamic>>.from(
                                    product['Reviews'] ?? []));

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
                                        builder: (context) =>
                                            ProductDetailsClass(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        productPic.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  productPic,
                                                  width: double.infinity,
                                                  height:
                                                      120, // Height for the image
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const Icon(Icons.image,
                                                size: 120, color: Colors.grey),
                                        const SizedBox(height: 10),
                                        Text(
                                          productName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Text.rich(
                                              TextSpan(
                                                text: '₱', // Peso symbol
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFFCA771A)),
                                              ),
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              price,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFFCA771A),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber,
                                                size: 16.0),
                                            Text(
                                              averageRating.toStringAsFixed(
                                                  1), // Display with 1 decimal place
                                            ),
                                            Text(' | 54 sold')
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 134, 134, 134),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
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
            ),
          ],
        ),
      ),
    );
  }
}

// Function to open the filter sidebar
void _openRightSideModal(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false, // Makes the modal background translucent
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Start off-screen to the right
            end: Offset.zero, // Slide into place
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: Scaffold(
            backgroundColor: Colors.black54, // Dim background
            body: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7, // Modal width
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(-2, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('By Tags'),
                      const SizedBox(height: 10),
                      // GridView for tags
                      SizedBox(
                        height: 150, // Adjust height as needed
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Text('Tag ${index + 1}'),
                            );
                          },
                        ),
                      ),
                      const Text('Filter 2'),
                      SizedBox(
                        height: 150, // Adjust height as needed
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Text('Tag ${index + 1}'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Filter 3'),
                      SizedBox(
                        height: 150, // Adjust height as needed
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Text('Tag ${index + 1}'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the modal
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Slide in from the right
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
      reverseTransitionDuration:
          const Duration(milliseconds: 300), // Reverse animation duration
      transitionDuration:
          const Duration(milliseconds: 300), // Animation duration
    ),
  );
}
