import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PayMongoService {
  static const String baseUrl = 'https://api.paymongo.com/v1';
  static String secretKey = dotenv.env['PAYMONGO_SECRET_KEY'] ?? 'default_api_key'; // Replace with your secret key

  Future<String?> createPaymentIntent({String? description, required int amount,  String? paymentMethod}) async {

    print('amount: ' + jsonEncode(amount.toInt()));


    final url = Uri.parse('$baseUrl/payment_intents');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$secretKey:')),
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'data': {
        'attributes': {
          'amount': amount.toInt(), // Amount in centavos
          'payment_method_allowed': ['gcash', 'card'], // Only include valid payment methods
          'currency': 'PHP', // Use the currency parameter
          'capture_type': 'automatic',
          'description': description, // Optional description
        }
      }
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['id']; // Payment intent ID
    } else {
      print('Failed to create payment intent: ${response.body}');
      return null;
    }
  }

  Future<String?> createPaymentMethod(String type, Map<String, dynamic> details) async {
    final url = Uri.parse('$baseUrl/payment_methods');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$secretKey:')),
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'data': {
        'attributes': {
          'type': type,
          'attributes': details,
        }
      }
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['id']; // Payment method ID
    } else {
      print('Failed to create payment method: ${response.body}');
      return null;
    }
  }

  Future<String?> attachPaymentMethod(String paymentIntentId, String paymentMethodId,  {String? returnUrl}) async {
    final url = Uri.parse('$baseUrl/payment_intents/$paymentIntentId/attach');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode(secretKey + ':')),
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'data': {
        'attributes': {
          'payment_method': paymentMethodId,
                  'return_url': returnUrl, // Add return_url here

        }
      }
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['attributes']['next_action']['redirect']['url'];
    } else {
      print('Failed to attach payment method: ${response.body}');
      return null;
    }
  }

  Future<void> createPaymentIntentSecond(double amount) async {
  const String apiKey = 'ysk_test_D8qXfBvwTfyjJNV776cn4kmE'; // Replace with your PayMongo secret key

  final response = await http.post(
    Uri.parse('https://api.paymongo.com/v1/payment_intents'),
    headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$apiKey:')),
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'data': {
        'attributes': {
          'amount': (amount * 100).toInt(), // Amount in cents
          'currency': 'PHP',
          'payment_method_types': ['gcash'], // Use 'gcash' for GCash payment
        },
      },
    }),
  );

  if (response.statusCode == 200) {
    // Payment intent created successfully
    var paymentIntent = jsonDecode(response.body);
    print('Payment Intent Created: ${paymentIntent}');
    // Handle the payment intent response here
  } else {
    // Handle error
    print('Failed to create payment intent: ${response.body}');
  }
}

  Future<String?> createPaymentLink({String? description, required int amount,  String? paymentMethod}) async {

    print('amount: ' + jsonEncode(amount.toInt()));


    final url = Uri.parse('https://api.paymongo.com/v1/links');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$secretKey:')),
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'data': {
        'attributes': {
          'amount': 10000, // Amount in centavos
          'payment_method_allowed': ['gcash', 'card'], // Only include valid payment methods
          'currency': 'PHP', // Use the currency parameter
          'capture_type': 'automatic',
          'description': description, // Optional description
        }
      }
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {


      final data = jsonDecode(response.body);
      return data['data']['attributes']['checkout_url']; // Payment intent ID
    } else {
      print('Failed to create payment intent: ${response.body}');
      return null;
    }
  }


 static Future<bool> checkPaymentStatus(String paymentIntentId) async {
    final url = 'https://api.paymongo.com/v1/payment_intents/$paymentIntentId';

    print('Checking payment status...');

    // Base64 encode the secret key for basic authentication
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$secretKey:'));

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
    );

  
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String status = jsonResponse['data']['attributes']['status'];

      return status == 'succeeded'; // Return true if payment succeeded
    } else {
      print('Error fetching payment status: ${response.statusCode}');
      return false; // Handle the case where the payment status is not succeeded
    }
  }

}
