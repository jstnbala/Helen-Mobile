// ignore_for_file: file_names, avoid_print, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/services/get_farmer_api.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-checkout.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';
import 'package:helen_app/src/services/get_serviceInfo_api.dart';
import 'package:logger/logger.dart'; // Import the logger package
import 'package:skeletonizer/skeletonizer.dart';
class ProductDetailsClass extends StatefulWidget {
  final String productPic;
  final String productName;
  final String quantity;
  final String price;
  final String productDetails;
  final String farmerName;
  final String organization;

  const ProductDetailsClass({
    super.key,
    required this.productPic,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.productDetails,
    required this.farmerName,
    required this.organization,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsClassState createState() => _ProductDetailsClassState();
}

class _ProductDetailsClassState extends State<ProductDetailsClass> {
  // Secure storage instance
  final storage = const FlutterSecureStorage();
  Map<String, dynamic>? serviceInfo;

  final Logger logger = Logger();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServiceInfo(); // Fetch service info when the widget is initialized
  }


  Future<void> _loadServiceInfo() async {
    try {
      // Fetch the farmer's data using the API
      final farmer = await GetFarmerApi().getFarmer(widget.farmerName);
      
      if (farmer != null && farmer['serviceInfo'] != null) {
        // Fetch the service info using the serviceInfo field
        final jsonString = await GetServiceInfoAPI().getServiceInfo(farmer['serviceInfo']);

        if (jsonString != null && jsonString.isNotEmpty) {
          setState(() {
            serviceInfo = jsonString; // Decode JSON data
            logger.i('Loaded serviceInfo: $serviceInfo'); // Info log
          });
        } else {
          logger.w('serviceInfo is null or empty'); // Warning log
        }
      } else {
        logger.w('Farmer or serviceInfo is null'); // Warning log
      }
    } catch (e) {
      logger.e('Error loading service info $e'); // Error log with stack trace
    } finally {
    if (mounted) { // Check if the widget is still mounted
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.productPic.isNotEmpty
                  ? Image.network(
                      widget.productPic,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : const Icon(
                      Icons.image,
                      size: 300.0,
                      color: Colors.grey,
                    ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Skeletonizer(
                  enabled: isLoading,
                  child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Divider(),
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.productName,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      Text(
                                        widget.quantity,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'PHP ${widget.price}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            // Farmer Information Section
                            const Row(
                              children: [
                                Icon(Icons.person, color: Color(0xFFCA771A), size: 20.0),
                                SizedBox(width: 8.0),
                                Text(
                                  'Farmer Information',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Farmer Name: ${widget.farmerName}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Organization: ${widget.organization}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            const Divider(),
                            // Product Details Section
                            const Row(
                              children: [
                                Icon(Icons.info, color: Color(0xFFCA771A), size: 20.0),
                                SizedBox(width: 8.0),
                                Text(
                                  'Product Details',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.productDetails,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            const Divider(),
                           // Mode of Delivery Section
                            const Row(
                              children: [
                                Icon(Icons.delivery_dining, color: Color(0xFFCA771A), size: 20.0),
                                SizedBox(width: 8.0),
                                Text(
                                  'Available Mode of Delivery',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),

                            // Check if the serviceInfo is still being fetched
                            if (serviceInfo == null)
                              // Show a loading indicator while the serviceInfo is being loaded
                              const Center(
                                child: Text(
                                  'Loading delivery options...',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            else if (serviceInfo!['modeOfDelivery'] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (serviceInfo!['modeOfDelivery'] as List<dynamic>)
                                    .map<Widget>((item) => Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            '$item',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              )
                            else
                              // If no delivery options are available
                              const Center(
                                child: Text(
                                  'No delivery options available',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFFCA771A),
                                      side: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Get the farmer data by awaiting the API call
                                      Map<String, dynamic>? farmer =
                                          await GetFarmerApi().getFarmer(widget.farmerName);

                                      // Check if a farmer was found
                                      if (farmer != null) {
                                        // Navigate to the SpecificMessagePage with farmer's details
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SpecificMessage(
                                              senderId: farmer['_id'],
                                              senderName: farmer['FullName'],
                                              senderProfile: farmer['ProfilePicture'],
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Handle case when no farmer is found, e.g., show an error message
                                        print('Farmer not found');
                                      }
                                    },
                                    child: const Text(
                                      'Message',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFFCA771A),
                                      side: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Passing product details to the checkout page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutPage(
                                            farmerName: widget.farmerName, 
                                            productPic: widget.productPic,
                                            productName: widget.productName,
                                            quantity: widget.quantity,
                                            price: widget.price,
                                            serviceInfo: serviceInfo,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Order',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
