// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class OrderListsInsti extends StatefulWidget {
  const OrderListsInsti({Key? key}) : super(key: key);

  @override
  _OrderListsInstiState createState() => _OrderListsInstiState();
}

class _OrderListsInstiState extends State<OrderListsInsti> {
  bool _isCompletedSelected = true;
  bool _isCancelledSelected = false;
  bool isExpanded = false; // Define isExpanded here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Orders List',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFFCA771A),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCompletedSelected = true;
                        _isCancelledSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isCompletedSelected
                          ? const Color(0xFFCA771A)
                          : Colors.white,
                      side: const BorderSide(color: Color(0xFFCA771A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: _isCompletedSelected
                            ? Colors.white
                            : const Color(0xFFCA771A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCompletedSelected = false;
                        _isCancelledSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isCancelledSelected
                          ? const Color(0xFFCA771A)
                          : Colors.white,
                      side: const BorderSide(color: Color(0xFFCA771A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancelled',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: _isCancelledSelected
                            ? Colors.white
                            : const Color(0xFFCA771A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_isCancelledSelected)
                      Container(
                        padding: const EdgeInsets.all(16.0),
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
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    'images/farmers/carrots.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Carrots',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Quantity: 10 Kilos',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Total: P200.00',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
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
                    if (_isCompletedSelected)
                      Container(
                        padding: const EdgeInsets.all(16.0),
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
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    'images/buyers/product-corn.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Corn',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Quantity: 10 Kilos',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Total: P100.00',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                      ),
                                      if (isExpanded) ...[
                                        const SizedBox(height: 10.0),
                                        const Text(
                                          'Organization: Lucban Farmers',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        const Text(
                                          'Farmer: Nestor Juan',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        const Text(
                                          'PickUp Address: Lucban Trading',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isExpanded ? Icons.expand_less : Icons.expand_more,
                                    color: Color(0xFFCA771A),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
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
          ],
        ),
      ),
    );
  }
}