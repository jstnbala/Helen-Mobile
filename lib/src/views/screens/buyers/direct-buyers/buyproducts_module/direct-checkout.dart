// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-qr_page.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final String farmerName; // Add farmerName parameter
  final String productPic;
  final String productName;
  final String quantity;
  final String price;
  final Map<String, dynamic>? serviceInfo; // Add serviceInfo parameter

  const CheckoutPage({
    super.key,
    required this.farmerName, // Make it required
    required this.productPic,
    required this.productName,
    required this.quantity,
    required this.price,
    this.serviceInfo, // Initialize serviceInfo
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedDeliveryOption;
  String? _selectedPaymentOption;
  int quantity = 1; // Initialize quantity

  @override
  Widget build(BuildContext context) {
    final List<String>? paymentModes =
        widget.serviceInfo?['modeOfPayment']?.cast<String>();
        

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [SizedBox(width: 56)],
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget.productPic,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                  Text(
                            widget.productName,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 15, 15, 15),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical:
                                    4.0), // Padding inside the green background
                            decoration: BoxDecoration(
                              color: Colors.green, // Background color
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                            ),
                            child: const Text(
                              'Tag',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                                          const SizedBox(height: 20),
                            const Divider(),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text(
                        "P ${ (double.parse(widget.price) * quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      Text(
                        "P ${widget.price} /unit",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(255, 78, 78, 78),
                        ),
                      ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1)
                                  quantity--; // Decrease quantity but keep it >= 1
                              });
                            },
                            icon: const Icon(Iconsax.minus_cirlce,
                                color: Color.fromARGB(255, 137, 137, 137)),
                          ),
                          Text(
                            "$quantity",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 30, 30, 30),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++; // Increase quantity
                              });
                            },
                            icon: const Icon(Iconsax.add_circle,
                                color: Color.fromARGB(255, 88, 88, 88)),
                          ),
                        ],
                      ),
                        Text(
                        "stock: ${widget.quantity}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromARGB(255, 119, 119, 119),
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                                            const Divider(),

                if (widget.serviceInfo != null &&
                    widget.serviceInfo!['modeOfDelivery'] != null)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color for the container
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                   child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      "Select Mode of Delivery:",
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFFCA771A),
      ),
    ),
    const SizedBox(height: 20.0),
    DropdownButton<String>(
      value: _selectedDeliveryOption,
      hint: const Text(
        "Choose a delivery option",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),
      isExpanded: true,  // Ensures the dropdown takes full width
      onChanged: (String? newValue) {
        setState(() {
          _selectedDeliveryOption = newValue!;
        });
      },
      items: (widget.serviceInfo!['modeOfDelivery'] as List<dynamic>)
          .map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(
          value: item as String,
          child: Text(
            item,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        );
      }).toList(),
    ),
  ],
),
                  )
                else
                  const Text(
                    'No delivery options available',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 10),

                if (paymentModes != null && paymentModes.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color for the container
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Mode of Payment:",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...paymentModes.map((mode) {
                          // Determine the correct image path based on the payment mode
                          String imagePath;
                          if (mode == 'Cash') {
                            imagePath = 'images/buyers/cash.jpg';
                          } else if (mode == 'GCash') {
                            imagePath = 'images/buyers/gcash.png';
                          } else if (mode == 'BankTransfer') {
                            imagePath = 'images/buyers/bank-transfer.png';
                          } else {
                            imagePath = ''; // Default case if needed
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPaymentOption = mode;
                                });
                                // Handle payment options here
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: _selectedPaymentOption == mode
                                      ? const Color.fromARGB(10, 202, 119, 26)
                                      : Colors.white,
                                  border: Border.all(
                                    color: _selectedPaymentOption == mode
                                        ? const Color.fromARGB(
                                            255, 202, 119, 26)
                                        : const Color.fromARGB(
                                            255, 177, 176, 176),
                                    width: _selectedPaymentOption == mode
                                        ? 2.0
                                        : 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Adjust the radius as needed
                                      child: Image.asset(
                                        imagePath,
                                        width:
                                            30.0, // Adjust the size of the icon as needed
                                        height: 24.0,
                                        fit: BoxFit
                                            .cover, // Ensures the image fits within the rounded container
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Space between the icon and the text
                                    Text(
                                      mode,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: _selectedPaymentOption == mode
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  )
                else
                  const Text(
                    'No payment options available',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                const SizedBox(height: 20),

                Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price Per Unit',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.price,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                         
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            height: 32.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                 (double.parse(widget.price) * quantity).toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                // Proceed to Payment Button
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width:
                        double.infinity, // Make the button span the full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Collecting user selections
                        final bool isDeliveryOptionSelected =
                            _selectedDeliveryOption != null;
                        final bool isPaymentOptionSelected =
                            _selectedPaymentOption != null;

                        // Define error messages
                        String errorMessage = '';

                        // Determine which options are missing and set the error message accordingly
                        if (!isDeliveryOptionSelected &&
                            !isPaymentOptionSelected) {
                          errorMessage =
                              'Please select both mode of delivery and payment.';
                        } else if (!isDeliveryOptionSelected) {
                          errorMessage = 'Please select a mode of delivery.';
                        } else if (!isPaymentOptionSelected) {
                          errorMessage = 'Please select a payment option.';
                        }

                        if (errorMessage.isNotEmpty) {
                          // Show error message if any selection is missing
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Add your logic for proceeding to payment here
                          print('product name : ${widget.productName}');
                          print('payment amount : ${widget.price}');
                          print('quantity : ${widget.quantity}');
                          print(
                              'mode of delivery : ${_selectedDeliveryOption}');
                          print('payment method : ${_selectedPaymentOption}');

                          // Navigate to QR page with the appropriate QR file
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                String? qrFilePath;

                                // Determine the QR file path based on the selected payment option
                                if (_selectedPaymentOption == 'GCash') {
                                  qrFilePath =
                                      widget.serviceInfo?['gcashQrFile'];
                                } else if (_selectedPaymentOption ==
                                    'BankTransfer') {
                                  qrFilePath =
                                      widget.serviceInfo?['bankTransferQrFile'];
                                }
                                // Handle the case for 'Cash' or other payment methods if needed

                                return DirectQRPage(
                                  farmerName: widget.farmerName,
                                  qrFilePath: qrFilePath,
                                  productName: widget.productName,
                                  price: widget.price,
                                  quantity: widget.quantity,
                                  selectedDeliveryOption:
                                      _selectedDeliveryOption,
                                  selectedPaymentOption: _selectedPaymentOption,
                                );
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFCA771A), // Button background color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      child: const Text(
                        'Proceed to Payment',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
