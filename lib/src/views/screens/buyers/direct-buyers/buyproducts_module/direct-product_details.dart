// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_farmer_api.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-checkout.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';
class ProductDetailsClass extends StatelessWidget {
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
              background: productPic.isNotEmpty
                  ? Image.network(
                      productPic,
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
                Container(
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
                                        productName,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      Text(
                                        quantity,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'PHP $price',
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Pickup Address',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Farmer Information',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Name: $farmerName',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Organization: $organization',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Product Details',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCA771A),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  productDetails,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFCA771A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                 onPressed: () async {
                                  // Get the farmer data by awaiting the API call
                                  Map<String, dynamic>? farmer = await GetFarmerApi().getFarmer(farmerName);

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
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFCA771A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CheckoutPage()),
                                      );
                                    },
                                    child: const Text(
                                      'Order',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
