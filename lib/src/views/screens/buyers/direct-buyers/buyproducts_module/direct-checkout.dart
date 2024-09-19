// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/direct-qr_page.dart';
import 'package:intl/intl.dart'; // For date formatting

class CheckoutPage extends StatefulWidget {
  final String? productPic;
  final String? productName;
  final String? quantity;
  final String? price;
  final Map<String, dynamic>? serviceInfo; // Add serviceInfo parameter

  const CheckoutPage({
    super.key,
    this.productPic,
    this.productName,
    this.quantity,
    this.price,
    this.serviceInfo, // Initialize serviceInfo
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {

     final List<String>? paymentModes = widget.serviceInfo?['modeOfPayment']?.cast<String>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [SizedBox(width: 56)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  widget.productPic ?? 'https://via.placeholder.com/150', // Placeholder image in case productPic is null
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName ?? 'Unknown Product', // Default value if productName is null
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        Text(
                          widget.quantity ?? 'Unknown Quantity', // Default value if quantity is null
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "PHP ${widget.price ?? '0.00'}", // Default value if price is null
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mode of Delivery:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              if (widget.serviceInfo != null && widget.serviceInfo!['modeOfDelivery'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.serviceInfo!['modeOfDelivery'] as List<dynamic>)
                      .map<Widget>((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              '$item',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ))
                      .toList(),
                )
              else
                const Text(
                  'No delivery options available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: selectedDate != null
                                ? DateFormat.yMd().format(selectedDate!)
                                : 'Select Date',
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFCA771A)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: selectedTime != null
                                ? selectedTime!.format(context)
                                : 'Select Time',
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.access_time, color: Color(0xFFCA771A)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Mode of Payment:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              // Display buttons for the available modes of payment
              if (paymentModes != null && paymentModes.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: paymentModes.map((mode) {
                    return _buildPaymentButton(context, mode);
                  }).toList(),
                )
              else
                const Text(
                  'No payment options available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 20), // Space provided but no buttons here
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build payment buttons based on mode
  Widget _buildPaymentButton(BuildContext context, String mode) {
    return ElevatedButton(
      onPressed: () {
        if (mode == 'GCash') {
          // Navigate to QR page with the GCash QR file
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DirectQRPage(
                qrFilePath: widget.serviceInfo?['gcashQrFile'], // Pass the GCash QR file
              ),
            ),
          );
        } else if (mode == 'BankTransfer') {
          // Navigate to QR page with the Bank Transfer QR file
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DirectQRPage(
                qrFilePath: widget.serviceInfo?['bankTransferQrFile'], // Pass the Bank Transfer QR file
              ),
            ),
          );
        }
        // Handle Cash separately, you can add other logic here if needed
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // White button background
        side: const BorderSide(color: Color(0xFFCA771A)), // Border color
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      child: Text(
        mode,
        style: const TextStyle(
          color: Color(0xFFCA771A), // Text color
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
