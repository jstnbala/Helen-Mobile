import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selectedPendingButton = 'Buyer'; // default selected button for Pending Orders
  String selectedHistoryButton = 'Completed'; // default selected button for Order History

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 18.0),
            Text(
              'Pending Orders',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFFCA771A),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: selectedPendingButton == 'Buyer' ? Color(0xFFCA771A) : Colors.white,
                    onPrimary: selectedPendingButton == 'Buyer' ? Colors.white : Color(0xFFCA771A),
                    side: BorderSide(color: Color(0xFFCA771A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPendingButton = 'Buyer';
                    });
                  },
                  child: Text(
                    'Buyer',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: selectedPendingButton == 'Buyer' ? Colors.white : Color(0xFFCA771A),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: selectedPendingButton == 'Institutional Buyer' ? Color(0xFFCA771A) : Colors.white,
                    onPrimary: selectedPendingButton == 'Institutional Buyer' ? Colors.white : Color(0xFFCA771A),
                    side: BorderSide(color: Color(0xFFCA771A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPendingButton = 'Institutional Buyer';
                    });
                  },
                  child: Text(
                    'Institutional Buyer',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: selectedPendingButton == 'Institutional Buyer' ? Colors.white : Color(0xFFCA771A),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (selectedPendingButton == 'Buyer')
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 115,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cauliflower',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'July 23, 2024 10:04 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Quantity: 25 kilos',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Total: 2500.00',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Color(0xFFCA771A),
                                        side: BorderSide(color: Color(0xFFCA771A)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        minimumSize: Size(75, 35),
                                      ),
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      child: Text(
                                        'Picked Up',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Color(0xFFCA771A),
                                        side: BorderSide(color: Color(0xFFCA771A)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        minimumSize: Size(75, 35),
                                      ),
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      child: Text(
                                        'Chat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (selectedPendingButton == 'Institutional Buyer')
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 115, // Reduced width
                            height: 120, // Reduced height
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cabbage',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'July 23, 2024 9:04 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Quantity: 100 kilos',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Total: 9500.00',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0), // Add space before buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xFFCA771A),
                              side: BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(75, 35),
                            ),
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA771A),
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xFFCA771A),
                              side: BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(75, 35),
                            ),
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA771A),
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xFFCA771A),
                              side: BorderSide(color: Color(0xFFCA771A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(75, 35),
                            ),
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                            child: Text(
                              'Chat',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA771A),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 30.0),
            Text(
              'Order History',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFFCA771A),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: selectedHistoryButton == 'Completed' ? Color(0xFFCA771A) : Colors.white,
                    onPrimary: selectedHistoryButton == 'Completed' ? Colors.white : Color(0xFFCA771A),
                    side: BorderSide(color: Color(0xFFCA771A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedHistoryButton = 'Completed';
                    });
                  },
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: selectedHistoryButton == 'Completed' ? Colors.white : Color(0xFFCA771A),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: selectedHistoryButton == 'Cancelled' ? Color(0xFFCA771A) : Colors.white,
                    onPrimary: selectedHistoryButton == 'Cancelled' ? Colors.white : Color(0xFFCA771A),
                    side: BorderSide(color: Color(0xFFCA771A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedHistoryButton = 'Cancelled';
                    });
                  },
                  child: Text(
                    'Cancelled',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: selectedHistoryButton == 'Cancelled' ? Colors.white : Color(0xFFCA771A),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (selectedHistoryButton == 'Completed')
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 115,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Spinach',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'July 23, 2024 11:04 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Quantity: 50 kilos',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Total: 4500.00',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (selectedHistoryButton == 'Cancelled')
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 115,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Broccoli',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'July 23, 2024 12:04 PM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Quantity: 30 kilos',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Total: 3000.00',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFCA771A),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
