// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/order_request_api.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/order_request_module/for_payment_page.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/order_request_module/insti-orderform.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
class HomepageInsti extends StatefulWidget {
  const HomepageInsti({Key? key}) : super(key: key);
  
  @override
  _HomepageInstiState createState() => _HomepageInstiState();
}

class _HomepageInstiState extends State<HomepageInsti> {
   bool _isAcceptedSelected = true;
  bool _isRequestedSelected = false;
  List<dynamic> requestedOrders = [];
  List<dynamic> acceptedOrders = [];
  bool _isLoadingRequested = false;
  bool _isLoadingAccepted = false;

  final String cachedRequestsKey = 'cachedRequests';
  final String cachedAcceptedOrdersKey = 'cachedRequestsForPayment';
  final String cachedTimestampKey = 'cacheTimestamp';

  @override
  void initState() {
    super.initState();
    fetchRequestedOrders();
    fetchAcceptedOrders();
  }

Future<void> fetchRequestedOrders() async {
  setState(() {
    _isLoadingRequested = true;
  });
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? cachedTimestamp = prefs.getInt(cachedTimestampKey);

  // Check if cached data is still valid (5 minutes)
  if (cachedTimestamp != null && DateTime.now().millisecondsSinceEpoch - cachedTimestamp < 5 * 60 * 1000) {
    String? cachedData = prefs.getString(cachedRequestsKey);
    if (cachedData != null) {
      requestedOrders = json.decode(cachedData);
      setState(() {
        _isLoadingRequested = false;
      });
      return; // No need to fetch new data
    }
  }

  // Fetch new data if cache is invalid or doesn't exist
  try {
    requestedOrders = await fetchRequests(); // This fetches and caches data in OrderRequest.dart
  } catch (e) {
    print('Error fetching requested orders: $e');
  } finally {
    setState(() {
      _isLoadingRequested = false;
    });
  }
}

Future<void> fetchAcceptedOrders() async {
  setState(() {
    _isLoadingAccepted = true;
  });
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? cachedTimestamp = prefs.getInt(cachedTimestampKey);

  // Check if cached data is still valid (5 minutes)
  if (cachedTimestamp != null && DateTime.now().millisecondsSinceEpoch - cachedTimestamp < 5 * 60 * 1000) {
    String? cachedData = prefs.getString(cachedAcceptedOrdersKey);
    if (cachedData != null) {
      acceptedOrders = json.decode(cachedData);
      setState(() {
        _isLoadingAccepted = false;
      });
      return; // No need to fetch new data
    }
  }

  // Fetch new data if cache is invalid or doesn't exist
  try {
    acceptedOrders = await fetchRequestsForPayment(); // This fetches and caches data in OrderRequest.dart
  } catch (e) {
    print('Error fetching accepted orders: $e');
  } finally {
    setState(() {
      _isLoadingAccepted = false;
    });
  }
}

    Future<void> _refreshData() async {
    // This method will refresh the fetched data when pulled down
    setState(() {
      _isLoadingRequested = true;
      _isLoadingAccepted = true;
    });

    // Fetch new data directly without using the cache
    try {
      requestedOrders = await fetchRequests(); // Always fetch from the server
      acceptedOrders = await fetchRequestsForPayment(); // Always fetch from the server
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      setState(() {
        _isLoadingRequested = false;
        _isLoadingAccepted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: _refreshData,
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),  // Ensure scrollability even if content is small

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderForm()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFCA771A),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Order Request',
                          style: TextStyle(
                            color: Color(0xFFCA771A),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'For large quantities of orders.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Modify the Pending Orders Section
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pending Orders',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAcceptedSelected = false;
                                _isRequestedSelected = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isRequestedSelected ? const Color(0xFFCA771A) : Colors.white,
                              side: const BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Requested',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: _isRequestedSelected ? Colors.white : const Color(0xFFCA771A),
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAcceptedSelected = true;
                                _isRequestedSelected = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isAcceptedSelected ? const Color(0xFFCA771A) : Colors.white,
                              side: const BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'For Payment',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: _isAcceptedSelected ? Colors.white : const Color(0xFFCA771A),
                              ),
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                    const SizedBox(height: 20.0),
              
              
if (_isRequestedSelected)
                        _isLoadingRequested
                            ? Center(child: CircularProgressIndicator())
                            : (requestedOrders.isEmpty)
                                ? Center(child: Text('No requests found.'))
                                : Column(
                                    children: requestedOrders.map((request) {
                                      return Container(
                                        padding: const EdgeInsets.all(16.0),
                                        margin: const EdgeInsets.only(bottom: 10.0),
                                        width: double.infinity, // Maximize the width
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              request['BuyerName'] ?? 'No Buyer Name',
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFCA771A),
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            
                                            ...List.generate(
                                              request['productDetails'].length,
                                              (index) {
                                                var product = request['productDetails'][index];
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Product: ${product['productName']}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14.0,
                                                        color: Color(0xFFCA771A),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Volume: ${product['volume']} ${product['unit']}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14.0,
                                                        color: Color(0xFFCA771A),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4.0),
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              'Description: ${request['Description'] ?? 'No Description'}',
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                         
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )
                  
else if (_isAcceptedSelected) 
  _isLoadingAccepted
    ? Center(child: CircularProgressIndicator())
    : (acceptedOrders.isEmpty)
        ? Center(child: Text('No accepted orders found.'))
        : Column(
            children: acceptedOrders.map((request) {
              return GestureDetector(
                onTap: () {
                  // Navigate to PriceBreakdownScreen with the selected request
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PriceBreakdownScreen(request: request),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  width: double.infinity, // Maximize the width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['BuyerName'] ?? 'No Buyer Name',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      ...List.generate(
                        request['OrderDetails'].length,
                        (index) {
                          var product = request['OrderDetails'][index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${product['farmerName']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              const Spacer(), // Adds space between farmerName and productName
                              Text(
                                '${product['productName']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              const Spacer(), // Adds space between productName and volume
                              Text(
                                '${product['volume']} ${product['unit']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              const SizedBox(height: 4.0), // Add spacing below the row if needed
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            }).toList(),
        )
                 ],
                ),
              ),
            ],
          ),
        ),
        )
      ),
    );
  }
}