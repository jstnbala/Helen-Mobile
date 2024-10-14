import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/api/paymongo_API.dart';
import 'package:helen_app/src/services/post_orders_api.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct_receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

 const FlutterSecureStorage secureStorage = FlutterSecureStorage();


class WebViewScreen extends StatefulWidget {
  final String paymentLink; // Payment link to load
  final String paymentIntentId; // Payment Intent ID passed from the previous screen
  final String productName;
  final String quantity;
  final String price;
  final String? selectedDeliveryOption;
  final String? selectedPaymentOption;
  final String farmerName; 

  const WebViewScreen({
    Key? key,
    required this.paymentLink,
    required this.paymentIntentId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.selectedDeliveryOption,
    required this.selectedPaymentOption,
    required this.farmerName, 
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  bool _isPaymentCheckActive = false; // Track if payment check is active

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            if (url.contains('/success')) { // Check if the URL contains '/success'
              if (_isPaymentCheckActive) return; // Avoid re-checking
              _isPaymentCheckActive = true; // Mark the payment check as active

              // Call the function from the PayMongoService to check payment status using the passed paymentIntentId
              bool isPaymentSuccessful = await PayMongoService.checkPaymentStatus(widget.paymentIntentId);

              // Check if the widget is still mounted before performing navigation
              if (mounted) {
                if (isPaymentSuccessful) {
                  String? buyerName = await secureStorage.read(key: 'FullName');

                  bool orderSuccess = await postOrders(
                    widget.farmerName,
                    buyerName ?? '',
                    widget.productName,
                    widget.price,
                    widget.quantity,
                    widget.selectedDeliveryOption ?? '',
                    widget.selectedPaymentOption ?? '',
                  );

                  if (!orderSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to create order. Please try again.')),
                    );
                    return;
                  }

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => DirectReceipt(
                        farmerName: widget.farmerName,
                        productName: widget.productName,
                        quantity: widget.quantity,
                        price: widget.price,
                        selectedDeliveryOption: widget.selectedDeliveryOption,
                        selectedPaymentOption: widget.selectedPaymentOption,
                      ),
                    ),
                    (route) => false, // Remove all previous routes
                  );
                } else {
                  // Handle failed payment (you can navigate to a failure page or show an alert)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => FailurePage(),
                    ),
                  );
                }
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentLink)); // Load the payment link
  }

  @override
  Widget build(BuildContext context) {
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
            'Payment',
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
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    // Ensure to clean up any resources used
    _isPaymentCheckActive = false; // Clean up on dispose
    super.dispose();
  }
}

class SuccessPage extends StatelessWidget {
  final String previousData; // Data from the previous screen

  const SuccessPage({Key? key, required this.previousData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text('Payment was successful! Data: $previousData'),
      ),
    );
  }
}

class FailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Failed'),
      ),
      body: Center(
        child: const Text('Payment failed. Please try again.'),
      ),
    );
  }
}
