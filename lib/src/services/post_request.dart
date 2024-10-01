// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:helen_app/main.dart';
import 'package:http/http.dart' as http;

class PostRequestAPI {
  static Future<bool> postRequest({
    required String buyerName,
    required String productName,
    required double price,
    required int quantity,
    required String unit,
    required String description,

  
  }) async {
    const url = 'https://helen-server-lmp4.onrender.com/api/requests';
   
    // Prepare the request data
    final requestData = {
      'BuyerName': buyerName,
      'productDetails': [
        {
          'productName': productName,
          'price': price,
          'volume': quantity, // assuming volume refers to quantity
          'unit': unit,
        }
      ],
      'Description': description,
      'Status': 'New',
    };

    print('request data $requestData');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData), // Encode the request data as JSON
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        return true; // Indicate success
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false; // Indicate failure
      }
    } catch (error) {
      print('Error occurred: $error');
      return false; // Indicate failure
    }
  }
}
