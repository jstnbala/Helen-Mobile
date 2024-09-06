// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/api_service.dart';
import 'dart:convert'; // For base64 decoding
import 'package:intl/intl.dart'; // For date formatting

class SpecificEvent extends StatelessWidget {
  final Event event;

  const SpecificEvent({super.key, required this.event});

  // Helper method to format the date
  String formatDate(String dateStr) {
    final DateTime parsedDate = DateTime.parse(dateStr);
    return DateFormat('MMMM d, yyyy').format(parsedDate);
  }

  // Helper method to format the time
  String formatTime(String dateStr) {
    final DateTime parsedTime = DateTime.parse(dateStr);
    return DateFormat('h:mm a').format(parsedTime);
  }

  @override
  Widget build(BuildContext context) {
    // Decode the base64 image
    final bytes = base64Decode(event.photo.split(',')[1]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
          children: [
            Center(
              child: Container(
                height: 300.0,
                width: 350.0,  // Increase the width of the image container
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFCA771A),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: MemoryImage(bytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              event.title, // Event Title
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCA771A),
              ),
              textAlign: TextAlign.center, // Center the text within its container
            ),
            const SizedBox(height: 10.0),
            buildDetailRow(Icons.calendar_today, 'Start Date:', formatDate(event.startDate)),
            const SizedBox(height: 10.0),
            buildDetailRow(Icons.calendar_today, 'End Date:', formatDate(event.endDate)),
            const SizedBox(height: 5.0),
            buildDetailRow(Icons.access_time, 'Time:', formatTime(event.startDate)),
            const SizedBox(height: 5.0),
            buildDetailRow(Icons.location_on, 'Location:', event.location),
            const SizedBox(height: 20.0),
            Text(
              event.description, // Event Description
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify, // Justify the text
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 20.0),
        const SizedBox(width: 8.0),
        Text(
          '$label ', // Add a space after the label
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value, // Event value
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
