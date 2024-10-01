import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/services/get_user_to_chat.dart';
import 'package:helen_app/src/services/post_orders_api.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';

class OrderInformation extends StatefulWidget {
  final dynamic order;

  const OrderInformation({Key? key, required this.order}) : super(key: key);

  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  String? userType;
  dynamic updatedOrder; // New variable to store updated order

  @override
  void initState() {
    super.initState();
    _getUserType();
  }

  Future<void> _getUserType() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? storedUserType = await secureStorage.read(key: 'UserType');
    setState(() {
      userType = storedUserType;
    });
  }

  // Method to show confirmation dialog for actions
  Future<void> _showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Perform the action
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use updatedOrder if it is not null, otherwise use widget.order
    final orderToDisplay = updatedOrder ?? widget.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                orderToDisplay['productPic'] ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            // Product Name
            Text(
              orderToDisplay['ProductName'] ?? 'No Product Name',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color(0xFFCA771A),
              ),
            ),
            const SizedBox(height: 8.0),

            // Farmer Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Farmer',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      '${orderToDisplay['FarmerName'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                if (userType == 'buyer') 
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCA771A)),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                        // Handle message button action
                        GetUserToChatService getUserToChatService = GetUserToChatService();
                        String farmerName = orderToDisplay['FarmerName'] ?? '';

                        try {
                          // Get user details by FullName
                          Map<String, String> senderDetails = await getUserToChatService.getUserToChatDetailsByFullName(farmerName);

                          // Navigate to SpecificMessage with sender details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpecificMessage(
                                senderId: senderDetails['id'] ?? '', // Assuming you have the 'id' in the response
                                senderName: farmerName,
                                senderProfile: senderDetails['ProfilePicture'] ?? '', // Use empty string if not available
                              ),
                            ),
                          );
                        } catch (e) {
                          // Handle any errors, such as user not found
                          print('Error fetching user details: $e');
                          // Optionally show a dialog or message to the user
                        }
                      },
                    child: const Text(
                      'Message',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Buyer Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Buyer',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      '${orderToDisplay['BuyerName'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                if (userType == 'farmer') 
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCA771A)),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () async {
                        // Handle message button action
                        GetUserToChatService getUserToChatService = GetUserToChatService();
                        String farmerName = orderToDisplay['FarmerName'] ?? '';

                        try {
                          // Get user details by FullName
                          Map<String, String> senderDetails = await getUserToChatService.getUserToChatDetailsByFullName(farmerName);

                          // Navigate to SpecificMessage with sender details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpecificMessage(
                                senderId: senderDetails['id'] ?? '', // Assuming you have the 'id' in the response
                                senderName: farmerName,
                                senderProfile: senderDetails['ProfilePicture'] ?? '', // Use empty string if not available
                              ),
                            ),
                          );
                        } catch (e) {
                          // Handle any errors, such as user not found
                          print('Error fetching user details: $e');
                          // Optionally show a dialog or message to the user
                        }
                      },
                    child: const Text(
                      'Message',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8.0),

            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),

            // Quantity and Unit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),  
                Text(
                  '${orderToDisplay['Quantity'] ?? 'N/A'} ${orderToDisplay['Unit'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),  
                Text(
                  'PHP ${orderToDisplay['Price'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Mode of Delivery
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mode of Delivery',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 94, 94, 94),
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  '${orderToDisplay['modeOfDelivery'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
                
            const SizedBox(height: 8.0),

            // Mode of Payment
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mode of Payment',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 94, 94, 94),
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  '${orderToDisplay['modeOfPayment'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
                
            const SizedBox(height: 16.0), // Add some space before buttons

            // Farmer Status
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Farmer Status',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),  
               Text(
                  orderToDisplay['FarmerStatus'] ?? 'N/A',
                  style: TextStyle(
                    color: orderToDisplay['FarmerStatus'] == 'Order Completed'
                        ? const Color.fromARGB(255, 0, 153, 0) // Set text color to green if status is 'Order Completed'
                         : orderToDisplay['FarmerStatus'] == 'Canceled'
                              ? const Color.fromARGB(255, 255, 0, 0) // Set text color to red if status is 'Canceled'
                              : const Color.fromARGB(255, 150, 150, 150), // Default color
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),

            // Buyer Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Buyer Status',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),  
              Text(
                orderToDisplay['BuyerStatus'] ?? 'N/A',
                    style: TextStyle(
                      color: orderToDisplay['BuyerStatus'] == 'Order Received'
                          ? const Color.fromARGB(255, 0, 153, 0) // Set text color to green if status is 'Order Received'
                          : orderToDisplay['BuyerStatus'] == 'Canceled'
                              ? const Color.fromARGB(255, 255, 0, 0) // Set text color to red if status is 'Canceled'
                              : const Color.fromARGB(255, 150, 150, 150), // Default color
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              ],
            ),
            const SizedBox(height: 16.0), // Add some space before buttons

            // Action Button
          Row(
            children: [
            Expanded(
            child: (userType != 'farmer' || orderToDisplay['FarmerStatus'] != 'Order Completed') &&
                  (userType != 'buyer' || orderToDisplay['BuyerStatus'] != 'Order Received')
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      _showConfirmationDialog(
                        title: userType == 'farmer'
                            ? 'Confirm Order Completed'
                            : 'Confirm Order Received',
                        content: userType == 'farmer'
                            ? 'Are you sure you want to mark this order as completed?'
                            : 'Are you sure you have received the order?',
                        onConfirm: () async {
                          String status = userType == 'farmer' ? 'Order Completed' : 'Order Received';

                          bool updateSuccessful = await updateStatus(orderToDisplay["_id"], status);
                          if (updateSuccessful) {
                            // Refetch the order details after updating
                            dynamic fetchedOrder = await refetchOrder(orderToDisplay["_id"]);
                            setState(() {
                              updatedOrder = fetchedOrder; // Update the state with the new order
                            });
                          }
                        },
                      );
                    },
                    child: Text(
                      userType == 'farmer' ? 'Order Completed' : 'Order Received',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox.shrink(), // This will not render anything if the condition is met
          ),

                      const SizedBox(width: 16.0), // Add some space between buttons
                     if (!(orderToDisplay['FarmerStatus'] == 'Order Completed' && 
                            orderToDisplay['BuyerStatus'] == 'Order Received')) ...[ // Check both statuses
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFEE4B2B), width: 2.0), // Set the border color to red
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              _showConfirmationDialog(
                                title: 'Confirm Order Cancellation',
                                content: 'Are you sure you want to cancel this order?',
                               onConfirm: () async {
                                  String status ='Canceled';

                                  bool updateSuccessful = await updateStatus(orderToDisplay["_id"], status);
                                  if (updateSuccessful) {
                                    // Refetch the order details after updating
                                    dynamic fetchedOrder = await refetchOrder(orderToDisplay["_id"]);
                                    setState(() {
                                      updatedOrder = fetchedOrder; // Update the state with the new order
                                    });
                                  }
                                },
                              );
                            },
                            child: const Text(
                              'Cancel Order',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: Color(0xFFEE4B2B), // Set text color to red
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
            
          ],
        ),
      ),
    );
  }
}
