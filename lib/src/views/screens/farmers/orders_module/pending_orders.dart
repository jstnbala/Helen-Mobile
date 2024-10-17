import 'package:flutter/material.dart';
import 'package:helen_app/src/services/post_orders_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'order_information.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  late ScrollController _scrollController;
  List<dynamic>? orders; // Variable to store orders
  String? userType;
  bool isLoading = true; // New variable to track loading state

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchOrders(); // Call fetchOrders to retrieve orders
    _getUserType();
  }

  Future<void> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedOrders = prefs.getString('PendingOrderCache');

    if (cachedOrders != null) {
      orders = json.decode(cachedOrders);
    } else {
      orders = await getPendingOrders();
    }

    if (mounted) {
      setState(() {
        isLoading = false; // Set loading to false once data is fetched
      });
    }
  }

  Future<void> refreshOrders() async {
    setState(() {
      isLoading = true; // Set loading to true when refreshing
    });
    orders = await getPendingOrders();
    if (mounted) {
      setState(() {
        isLoading = false; // Set loading to false once refreshed
      });
    }
  }

  Future<void> _getUserType() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? storedUserType = await secureStorage.read(key: 'UserType');
    setState(() {
      userType = storedUserType;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refreshOrders,
        child: ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(const Color(0xFFCA771A)),
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 8.0,
            radius: const Radius.circular(10),
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              children: [
                Center(
                  child: Image.asset(
                    'images/farmers/pending_header.png',
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                if (isLoading) ...[
                  const Skeletonizer(
                    child: SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ] else if (orders == null || orders!.isEmpty) ...[
                  const Center(child: Text('No pending orders available.')),
                ] else ...[
                  for (var order in orders!)
                    buildOrderCard(order),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderCard(dynamic order) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderInformation(order: order),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: order['productPic'] ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['ProductName'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Color(0xFFCA771A), size: 16),
                          const SizedBox(width: 4.0),
                          Text(
                            userType == 'farmer'
                                ? order['BuyerName'] ?? 'N/A'
                                : order['FarmerName'] ?? 'N/A',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFCA771A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.attach_money, color: Color(0xFFCA771A), size: 16),
                          const SizedBox(width: 4.0),
                          Text(
                            "PHP ${order['Price']}",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                        ],
                      ),
                    ],
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
