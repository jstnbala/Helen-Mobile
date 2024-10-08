// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isCashSelected = false;
  bool isGcashSelected = false;
  bool isBankTransferSelected = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'images/buyers/tomato.png',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tomato",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        Text(
                          "Kilos",
                          style: TextStyle(
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
                    "P00.00",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quantity",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.remove, color: Colors.black),
                          onPressed: () {
                            // Decrease quantity
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "1",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            // Increase quantity
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pickup Address:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "123 Lucban Trading Post, Brgy 23, Quezon Province",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pickup Date & Time:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFCA771A),
                  ),
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
                  "Payment Options",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCashSelected ? const Color(0xFFCA771A) : Colors.white,
                        side: const BorderSide(color: Color(0xFFCA771A)),
                      ),
                      onPressed: () {
                        setState(() {
                          isCashSelected = true;
                          isGcashSelected = false;
                          isBankTransferSelected = false;
                        });
                      },
                      child: Text(
                        "Cash",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isCashSelected ? Colors.white : const Color(0xFFCA771A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isGcashSelected ? const Color(0xFFCA771A) : Colors.white,
                        side: const BorderSide(color: Color(0xFFCA771A)),
                      ),
                      onPressed: () {
                        setState(() {
                          isCashSelected = false;
                          isGcashSelected = true;
                          isBankTransferSelected = false;
                        });
                      },
                      child: Text(
                        "GCash",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isGcashSelected ? Colors.white : const Color(0xFFCA771A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isBankTransferSelected ? const Color(0xFFCA771A) : Colors.white,
                        side: const BorderSide(color: Color(0xFFCA771A)),
                      ),
                      onPressed: () {
                        setState(() {
                          isCashSelected = false;
                          isGcashSelected = false;
                          isBankTransferSelected = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          "Bank Transfer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: isBankTransferSelected ? Colors.white : const Color(0xFFCA771A),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isCashSelected) buildCashSection(),
            ],
          ),
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

  Widget buildCashSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        buildSummaryRow("Price:", "25.00", isTotal: false, color: const Color(0xFFCA771A)),
        buildSummaryRow("Quantity:", "10 kilos", isTotal: false, color: const Color(0xFFCA771A)),
        buildSummaryRow("Total:", "250.00", isTotal: true, color: const Color(0xFFCA771A)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton("Cancel"),
            buildActionButton("Confirm"),
          ],
        ),
      ],
    );
  }

  Widget buildSummaryRow(String label, String amount, {bool isTotal = false, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 20 : 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget buildActionButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFCA771A)),
      ),
      onPressed: () {
        setState(() {
          // Handle button press
        });
      },
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFFCA771A),
        ),
      ),
    );
  }
}
