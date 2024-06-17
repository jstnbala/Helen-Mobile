import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selectedCard = 'Completed'; // default selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Orders',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C7230),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Pending Orders Card
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCard = 'Pending';
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C7230),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Orders',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '02',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Canceled Orders Card
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCard = 'Canceled';
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C7230),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Canceled',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Completed Orders Card
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCard = 'Completed';
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C7230),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Completed',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: selectedCard == 'Completed'
                  ? Text(
                      'Your Completed Orders will reflect here',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C7230),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : selectedCard == 'Pending'
                      ? ListView(
                          children: [
                            OrderCard(
                              imagePath: 'images/farmers/carrots.png',
                              productName: 'Carrots',
                              kilos: '10 kilos',
                              quantity: '0',
                              price: 'P00.00',
                              deliveryStatusOptions: [
                                'Ready to Pick Up',
                                'Preparing to Pick Up'
                              ],
                              initialDeliveryStatus: 'Ready to Pick Up',
                              rightButtonText: 'Picked Up',
                            ),
                            SizedBox(height: 16.0),
                            OrderCard(
                              imagePath: 'images/farmers/carrots.png',
                              productName: 'Carrots',
                              kilos: '10 kilos',
                              quantity: '0',
                              price: 'P00.00',
                              deliveryStatusOptions: [
                                'On Delivery',
                                'Preparing for Delivery'
                              ],
                              initialDeliveryStatus: 'On Delivery',
                              rightButtonText: 'Delivered',
                            ),
                          ],
                        )
                      : Text(
                          'Your Canceled Orders will reflect here',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C7230),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
            ),
          ),
          if (selectedCard == 'Completed')
            Container(
              color: Color(0xFF0C7230),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Income:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'P00.00',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String kilos;
  final String quantity;
  final String price;
  final List<String> deliveryStatusOptions;
  final String initialDeliveryStatus;
  final String rightButtonText;

  OrderCard({
    required this.imagePath,
    required this.productName,
    required this.kilos,
    required this.quantity,
    required this.price,
    required this.deliveryStatusOptions,
    required this.initialDeliveryStatus,
    required this.rightButtonText,
  });

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;
  String? deliveryStatus;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    deliveryStatus = widget.initialDeliveryStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      color: Color(0xFF0C7230),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    widget.imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.kilos,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.quantity,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.price,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                  onPressed: toggleExpand,
                ),
              ],
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buyer: Sample Name',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Contact: 09123456789',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Mode of Delivery: Pickup',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Pickup Time: 00/00/00 10:00AM',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Status',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    DropdownButton<String>(
                      value: deliveryStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          deliveryStatus = newValue;
                        });
                      },
                      dropdownColor: Color(0xFF0C7230),
                      items: widget.deliveryStatusOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Color(0xFF0C7230),
                            side: BorderSide(color: Color(0xFF0C7230)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(150, 40),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Message',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Color(0xFF0C7230),
                            side: BorderSide(color: Color(0xFF0C7230)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(150, 40),
                          ),
                          onPressed: () {
                            // Implement the action for the button based on delivery status
                            if (deliveryStatus == 'Ready to Pick Up' ||
                                deliveryStatus == 'On Delivery') {
                              // Implement action for "Picked Up" or "Delivered"
                            } else if (deliveryStatus ==
                                    'Preparing to Pick Up' ||
                                deliveryStatus == 'Preparing for Delivery') {
                              // Implement action for "Delivered"
                            }
                          },
                          child: Text(
                            widget.rightButtonText,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0C7230),
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
      ),
    );
  }
}
