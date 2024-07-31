// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  DateTime? pickupDate;
  DateTime? deliveryDate;
  String? selectedInventory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        title: Text(
          'Add Products',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Big Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
              ),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  // Add functionality here
                },
                child: Container(
                  height: 200, // Adjust as needed
                  child: Center(
                    child: Icon(
                      Icons.cloud_upload,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Small Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => Flexible(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        // Add functionality here
                      },
                      child: Container(
                        height: 100, // Adjust as needed
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Product Name
            Text(
              'Product Name',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Type Here...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Price
            Text(
              'Selling Price',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Type Here...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Pickup Address
            Text(
              'Pickup Address',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Type Here...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Pickup Dates
            Text(
              'Pickup Dates',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  // Optional: You can add more customization here
                );
                if (pickedDate != null) {
                  setState(() {
                    pickupDate = pickedDate;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: pickupDate != null
                    ? '${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}'
                    : 'Select Here',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),

            // Delivery Dates
            Text(
              'Delivery Dates',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  // Optional: You can add more customization here
                );
                if (pickedDate != null) {
                  setState(() {
                    deliveryDate = pickedDate;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: deliveryDate != null
                    ? '${deliveryDate!.day}/${deliveryDate!.month}/${deliveryDate!.year}'
                    : 'Select Here',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),

            // Product Details
            Text(
              'Product Details',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextFormField(
              maxLines: 5, // Increased height
              decoration: InputDecoration(
                hintText: 'Type Here...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Inventory
            Text(
              'Inventory',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Numbers Only',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    value: selectedInventory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedInventory = newValue as String?;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Kilos',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'item1',
                        child: Text('Item 1'),
                      ),
                      DropdownMenuItem(
                        value: 'item2',
                        child: Text('Item 2'),
                      ),
                      // Add more items as needed
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Add Button
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFCA771A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Decrease font size
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
