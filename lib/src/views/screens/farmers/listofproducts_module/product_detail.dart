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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 157, 74),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xFFCA771A),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // Heart Button
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0), // Reduced space between buttons and image

            // Display the product image with border radius
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4, // Dynamic height
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // Dynamic width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius here
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
                          placeholder: (context, url) => const CircularProgressIndicator(),
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
            ),

            // White box with border radius
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: const EdgeInsets.all(25.0),
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
                            overflow: TextOverflow.ellipsis, // Handle overflow
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
                          "Quantity: ${widget.quantity}",
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
                    Text(
                      widget.productDetails,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Status
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFFCA771A)),
                        SizedBox(width: 8.0),
                        Text(
                          "Your product status is currently:",
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

                    // Status Label
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0), // Adjusted padding
                        decoration: BoxDecoration(
                          color: statusColor, // Dynamic color based on status
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          widget.status,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
