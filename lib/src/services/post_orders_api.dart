import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // Import the logger package
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create a logger instance
final Logger logger = Logger();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<bool> postOrders(
  String farmerName, 
  String buyerName, 
  String productName, 
  String price, 
  String quantity, 
  String modeOfDelivery, 
  String modeOfPayment) async {

  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders');

  // Convert price to double
  double parsedPrice;
  
  try {
    parsedPrice = double.parse(price);
  } catch (e) {
    logger.e('Invalid price format: $price'); // Log error for invalid price
    return false; // Exit if the price format is invalid
  }

  // Separate numeric part and unit from quantity
  int parsedQuantity;
  String unit = '';

  final quantityMatch = RegExp(r'(\d+)\s*([a-zA-Z]+)').firstMatch(quantity);
  if (quantityMatch != null) {
    parsedQuantity = int.parse(quantityMatch.group(1)!); // Numeric part
    unit = quantityMatch.group(2)!; // Unit part
  } else {
    logger.e('Invalid quantity format: $quantity'); // Log error for invalid quantity
    return false; // Exit if the quantity format is invalid
  }

  // Data to be sent to the server
  final Map<String, dynamic> orderData = {
    "FarmerName": farmerName,
    "BuyerName": buyerName,
    "ProductName": productName,
    "Price": parsedPrice, // Use the parsed double value
    "Quantity": parsedQuantity, // Use the parsed int value
    "Unit": unit, // Store the unit as a separate field
    "modeOfDelivery": modeOfDelivery,
    "modeOfPayment": modeOfPayment,
    "FarmerStatus": "not yet confirmed",
    "BuyerStatus": "not yet received",
    "status": "Pending" // Default status (if applicable)
  };

  logger.i("Posting order: $orderData"); // Log info about the order being posted

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(orderData),
    );

    if (response.statusCode == 200) { // Updated to check for status code 201
      logger.i('Order successfully created.'); // Log success message

      // After successfully creating the order, update the product status
      bool isProductUpdated = await updateProduct(productName, farmerName);
      if (isProductUpdated) {
        logger.i('Product status successfully updated to "ordered".');
        return true; // Return true if both order creation and product update succeed
      } else {
        logger.e('Failed to update product status.');
        return false; // Return false if product update fails
      }
      
    } else {
      logger.e('Failed to create order. Status code: ${response.statusCode}'); // Log error with status code
      return false; // Return false if the order creation fails
    }
  } catch (e) {
    logger.e('Error posting order: $e'); // Log any errors that occur
    return false; // Return false if an exception occurs
  }
}



Future<bool> updateProduct(String productName, String farmerName) async {
  try {
    // Step 1: Fetch the product details using the product name and farmer name
    final Uri getUrl = Uri.parse('https://helen-server-lmp4.onrender.com/api/products')
        .replace(queryParameters: {
          'ProductName': productName,
          'FarmerName': farmerName,
        });

    final getResponse = await http.get(getUrl, headers: {"Content-Type": "application/json"});

    // Check if the GET request was successful
    if (getResponse.statusCode != 200) {
      logger.e('Failed to fetch product. Status code: ${getResponse.statusCode}');
      return false; // Return false if the product is not found or an error occurs
    }

    // Parse the product details from the response
    final productData = json.decode(getResponse.body);

    // Check if productData is a list and contains products
    if (productData is List && productData.isNotEmpty) {
      // Access the first product from the list
      final product = productData[0];

      // Check if product contains 'id' field
      if (product != null && product.containsKey('_id')) {
        final String productId = product['_id'];

        // Step 2: Update the product status using the productId
        final Uri updateUrl = Uri.parse('https://helen-server-lmp4.onrender.com/api/products/$productId');

        final body = json.encode({
          "status": "Ordered", // Set the product status to 'ordered'
        });

        final putResponse = await http.put(
          updateUrl,
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        // Check if the PUT request was successful
        if (putResponse.statusCode == 200) {
          logger.i('Product successfully updated.');
          return true; // Return true if the update is successful
        } else {
          logger.e('Failed to update product. Status code: ${putResponse.statusCode}');
          return false; // Return false if the update fails
        }
      } else {
        logger.e('Product ID not found in the response.');
        return false;
      }
    } else {
      logger.e('No product found or unexpected response format.');
      return false;
    }
  } catch (e) {
    logger.e('Error occurred: $e');
    return false; // Return false if an exception occurs
  }
}


Future<List<dynamic>?> getPendingOrders() async {
  // Retrieve the FullName and type from secure storage
  String? fullName = await secureStorage.read(key: 'FullName');
  String? userType = await secureStorage.read(key: 'UserType'); // Assuming the key for type is 'UserType'

  // Check if the required data is available
  if (fullName == null || userType == null) {
    logger.e('FullName or UserType not found in secure storage.');
    return null; // Exit if any required information is missing
  }

  // Construct the API URL based on the user type, filtering out completed and received orders
  String queryParam = '';
  if (userType.toLowerCase() == 'farmer') {
    queryParam = 'FarmerName=$fullName&PendingOrder=true';
  } else if (userType.toLowerCase() == 'buyer') {
    queryParam = 'BuyerName=$fullName&PendingOrder=true';
  }

  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders/?$queryParam');

  logger.i('Fetching orders with URL: $url'); // Log the URL being queried

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved orders
      List<dynamic> orders = json.decode(response.body);
      logger.i('Orders retrieved successfully: $orders');

      // Iterate over each order and get the ProductPic
      for (var order in orders) {
        String productName = order['ProductName']; 
        String farmerName = order['FarmerName']; 

        // Get the product pic for the respective order
        String? productPic = await getProductPic(productName, farmerName);
       
        order['productPic'] = productPic;
        if (productPic != null) {
          logger.i('Product Pic for ${order['OrderId']}: $productPic'); // Assuming there is an OrderId field
        } else {
          logger.w('No Product Pic found for ${order['OrderId']}.');
        }
      }
      return orders; // Return the list of orders with ProductPics added
    } else {
      logger.e('Failed to fetch orders. Status code: ${response.statusCode}');
      return null; // Indicate failure
    }
  } catch (e) {
    logger.e('Error fetching orders: $e'); // Log any errors
    return null; // Indicate failure
  }
}

Future<List<dynamic>?> getCompletedOrders() async {
  // Retrieve the FullName and type from secure storage
  String? fullName = await secureStorage.read(key: 'FullName');
  String? userType = await secureStorage.read(key: 'UserType'); // Assuming the key for type is 'UserType'

  // Check if the required data is available
  if (fullName == null || userType == null) {
    logger.e('FullName or UserType not found in secure storage.');
    return null; // Exit if any required information is missing
  }

  // Construct the API URL based on the user type, filtering out completed and received orders
  String queryParam = '';
  if (userType.toLowerCase() == 'farmer') {
    queryParam = 'FarmerName=$fullName&CompletedOrder=true';
  } else if (userType.toLowerCase() == 'buyer') {
    queryParam = 'BuyerName=$fullName&CompletedOrder=true';
  }

  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders/?$queryParam');

  logger.i('Fetching orders with URL: $url'); // Log the URL being queried

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved orders
      List<dynamic> orders = json.decode(response.body);
      logger.i('Orders retrieved successfully: $orders');

      // Iterate over each order and get the ProductPic
      for (var order in orders) {
        String productName = order['ProductName']; 
        String farmerName = order['FarmerName']; 

        // Get the product pic for the respective order
        String? productPic = await getProductPic(productName, farmerName);
       
        order['productPic'] = productPic;
        if (productPic != null) {
          logger.i('Product Pic for ${order['OrderId']}: $productPic'); // Assuming there is an OrderId field
        } else {
          logger.w('No Product Pic found for ${order['OrderId']}.');
        }
      }
      return orders; // Return the list of orders with ProductPics added
    } else {
      logger.e('Failed to fetch orders. Status code: ${response.statusCode}');
      return null; // Indicate failure
    }
  } catch (e) {
    logger.e('Error fetching orders: $e'); // Log any errors
    return null; // Indicate failure
  }
}


Future<dynamic> refetchOrder(String orderId) async {
  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders/$orderId');

  logger.i('Fetching order with URL: $url'); // Log the URL being queried

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved a single order
      final order = json.decode(response.body); // Decode the JSON response

      // Ensure the required fields are present
      String productName = order['ProductName'];
      String farmerName = order['FarmerName'];

      // Get the product pic for the respective order
      String? productPic = await getProductPic(productName, farmerName);

      // Append the productPic to the order
      order['productPic'] = productPic;

      if (productPic != null) {
        logger.i('Product Pic for Order ID ${order['OrderId']}: $productPic');
      } else {
        logger.w('No Product Pic found for Order ID ${order['OrderId']}');
      }

      logger.i('Order retrieved successfully: $order');

      return order; // Return the single order with ProductPic added
    } else {
      logger.e('Failed to fetch order. Status code: ${response.statusCode}');
      return null; // Indicate failure
    }
  } catch (e) {
    logger.e('Error fetching order: $e'); // Log any errors
    return null; // Indicate failure
  }
}

Future<String?> getProductPic(String productName, String farmerName) async {
  // Build the query parameters
  final Uri url = Uri.parse('https://helen-server-lmp4.onrender.com/api/products/')
      .replace(queryParameters: {
        'ProductName': productName,
        'FarmerName': farmerName,
      });

  logger.i('Fetching products with URL: $url'); // Log the URL being queried

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully retrieved products
      List<dynamic> products = json.decode(response.body);
      logger.i('Products retrieved successfully: $products');

      // Return the ProductPic of the first product
      if (products.isNotEmpty) {
        return products[0]['ProductPic']; // Return the first ProductPic found
      } else {
        logger.w('No products found for the specified criteria.');
        return null; // Indicate no products were found
      }
    } else {
      logger.e('Failed to fetch products. Status code: ${response.statusCode}');
      return null; // Indicate failure
    }
  } catch (e) {
    logger.e('Error fetching products: $e'); // Log any errors
    return null; // Indicate failure
  }
}

Future<bool> updateStatus(
    String orderId,
    String status,
) async {
  final url = Uri.parse('https://helen-server-lmp4.onrender.com/api/orders/$orderId');
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? userType = await secureStorage.read(key: 'UserType'); // Fetch user type from secure storage

  // Prepare order data based on the user type
  final Map<String, dynamic> orderData = {};

  if (userType == 'buyer') {
    orderData["BuyerStatus"] = status;
  } else if (userType == 'farmer') {
    orderData["FarmerStatus"] = status;
  }

  logger.i("Updating order: $orderData"); // Log info about the update being posted

  try {
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(orderData),
    );

    if (response.statusCode == 200) {
      logger.i('Order successfully updated.'); // Log success message
      return true; // Return true if the update is successful
    } else {
      logger.e('Failed to update order. Status code: ${response.statusCode}'); // Log error with status code
      return false; // Return false if the update fails
    }
  } catch (e) {
    logger.e('Error updating order: $e'); // Log any errors that occur
    return false; // Return false if an exception occurs
  }
}


