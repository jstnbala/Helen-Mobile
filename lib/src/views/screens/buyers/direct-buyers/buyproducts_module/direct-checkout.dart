// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:helen_app/src/api/paymongo_API.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/web_view_payment_screen.dart';

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
  String? _selectedPaymentOption; // Add this line to track selected payment option

  @override
  Widget build(BuildContext context) {
    final List<String>? paymentModes = widget.serviceInfo?['modeOfPayment']?.cast<String>();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                          Text(
                            widget.quantity,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "PHP ${widget.price}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (widget.serviceInfo != null && widget.serviceInfo!['modeOfDelivery'] != null)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
                        ... (widget.serviceInfo!['modeOfDelivery'] as List<dynamic>)
                          .map<Widget>((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedDeliveryOption = item as String;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    width: double.infinity, // Ensure the container takes full width of its parent
                                    decoration: BoxDecoration(
                                      color: _selectedDeliveryOption == item
                                          ? const Color.fromARGB(10, 202, 119, 26)
                                          : Colors.white, // Use white for unselected options
                                      border: Border.all(
                                        color: _selectedDeliveryOption == item
                                            ? const Color.fromARGB(255, 202, 119, 26)
                                            : const Color.fromARGB(255, 177, 176, 176),
                                        width: _selectedDeliveryOption == item
                                            ? 2.0
                                            : 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      '$item',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: _selectedDeliveryOption == item
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
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
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
                                    ? const Color.fromARGB(255, 202, 119, 26)
                                    : const Color.fromARGB(255, 177, 176, 176),
                                width: _selectedPaymentOption == mode ? 2.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mode,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: _selectedPaymentOption == mode
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                if (imagePath.isNotEmpty)
                                  Image.asset(
                                    imagePath,
                                    height: 20,
                                    width: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      PayMongoService payMongoService = PayMongoService();
                      String selectedPaymentMethod;
                      Map<String, dynamic> paymentMethodDetails;
                      const returnUrl = 'https://helen-opaquezon.online/success'; // Replace with your actual return URL


                      if (_selectedPaymentOption == null) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a payment option')),
                        );
                        return; // Exit the function if no payment option is selected
                      }

                      if (_selectedPaymentOption == 'GCash') {
                        selectedPaymentMethod = 'gcash';
                        paymentMethodDetails = {
                          'mobile_number': '09123456789', // Replace with actual mobile number
                          // Add any other required fields
                        };
                      } else if (_selectedPaymentOption == 'BankTransfer') {
                        selectedPaymentMethod = 'card'; // Use appropriate value based on PayMongo documentation
                        paymentMethodDetails = {
                          'account_number': '1234567890', // Replace with actual account number
                          'account_name': 'Your Account Name',
                          // Add any other required fields
                        };
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid payment option selected')),
                        );
                        return; // Exit the function if the payment option is invalid
                      }
                                          
                      // Create a payment intent with PayMongo based on the selected payment method
                      final paymentIntentId = await payMongoService.createPaymentIntent(
                        amount: (double.parse(widget.price) * 100).toInt(), // Amount in cents
                        paymentMethod: _selectedPaymentOption!,
                        description: 'Payment for ${widget.productName}',
                      );

                      
                      if (paymentIntentId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create payment intent')),
                        );
                        return;
                      }
        
                      final paymentMethodId = await payMongoService.createPaymentMethod(selectedPaymentMethod, paymentMethodDetails);

                      if (paymentMethodId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create payment intent')),
                        );
                        return;
                      }
   
                      // Attach the payment method to the created payment intent
                      final paymentLink = await payMongoService.attachPaymentMethod(paymentIntentId, paymentMethodId, returnUrl: returnUrl);

                      if (paymentLink == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to attach payment method')),
                        );
                        return;
                      }

                      // Navigate to the WebViewPaymentScreen with the payment link
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            paymentLink: paymentLink,
                            paymentIntentId: paymentIntentId,
                            farmerName: widget.farmerName, 
                            productName: widget.productName,
                            price: widget.price,
                            quantity: widget.quantity,
                            selectedDeliveryOption: _selectedDeliveryOption,
                            selectedPaymentOption: _selectedPaymentOption,
                          ),
                        ),
                      );
                    
                       
                     
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCA771A),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Proceed to Payment',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
