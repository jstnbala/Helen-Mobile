import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FarmerProductDetail extends StatefulWidget {
  final String productName;
  final String quantity;
  final String price;
  final String status;
  final String productPic;
  final String productDetails;

  const FarmerProductDetail({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.status,
    required this.productPic,
    required this.productDetails,
  });

  @override
  _FarmerProductDetailState createState() => _FarmerProductDetailState();
}

class _FarmerProductDetailState extends State<FarmerProductDetail> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // Determine status color
    Color statusColor;
    switch (widget.status.toLowerCase()) {
      case 'verified':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'pending':
      default:
        statusColor = const Color(0xFFCA771A);
        break;
    }

    final List<Map<String, dynamic>> orderList = [
      {"buyerName": "John Doe", "quantity": 3, "price": 450},
      {"buyerName": "Jane Smith", "quantity": 5, "price": 750},
      {"buyerName": "Alice Johnson", "quantity": 2, "price": 300},
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 157, 74),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFCA771A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFFCA771A),
            ),
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: widget.productPic.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.productPic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image,
                          size: 150.0,
                          color: Colors.grey,
                        ),
                      )
                    : Icon(
                        Icons.image,
                        size: 150.0,
                        color: Colors.grey.shade300,
                      ),
              ),
            ),

            // Product Details Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name of the Product and Price
                  Row(
                    children: [
                      const Icon(Icons.label, color: Color(0xFFCA771A)),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          widget.productName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCA771A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "PHP ${widget.price}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),

                  // Quantity
                  Row(
                    children: [
                      const Icon(Icons.sort, color: Color(0xFFCA771A)),
                      const SizedBox(width: 8.0),
                      Text(
                        "Stock: ${widget.quantity}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),

                  // Product Details
                  const Row(
                    children: [
                      Icon(Icons.info, color: Color(0xFFCA771A)),
                      SizedBox(width: 8.0),
                      Text(
                        "Product Details:",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.productDetails,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Order List
                  const Text(
                    "Order List:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      final order = orderList[index];
                      return ListTile(
                        title: Text(order['buyerName']),
                        subtitle: Text("Quantity: ${order['quantity']}"),
                        trailing: Text("PHP ${order['price']}"),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Restock Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // Add your restock logic here
                    },
                    child: const Text(
                      "Restock",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
