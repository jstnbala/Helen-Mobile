// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:cached_network_image/cached_network_image.dart';

class SpecificProjects extends StatelessWidget {
  final Map<String, dynamic> project; // Changed to accept a single project

  const SpecificProjects({super.key, required this.project}); // Accept a single project

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
          'Project Details',
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
                height: 180.0,
                width: 350.0,  // Increase the width of the image container
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFCA771A),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(project['projectPic']), // Use projectPic for the image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              project['title'], // Use title from project data
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCA771A),
              ),
              textAlign: TextAlign.center, // Center the text within its container
            ),
            const SizedBox(height: 15.0),
            buildDetailRow(Icons.calendar_today, 'Date Added:', formatDate(project['dateAdded'])), // Use dateAdded
            const SizedBox(height: 10.0),
            buildDetailRow(Icons.check_circle, 'Status:', project['status']), // Use status
            const SizedBox(height: 20.0),
            Text(
              project['description'], // Use description from project data
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
            value, // Use value from project data
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
