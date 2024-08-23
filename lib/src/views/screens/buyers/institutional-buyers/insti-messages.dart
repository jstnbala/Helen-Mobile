// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagesInsti extends StatelessWidget {
  const MessagesInsti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Get current date and time
    final now = DateTime.now();
    final formattedDateTime = DateFormat('MMM d, yyyy h:mm a').format(now); // Format date and time

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: Text(
          'Messages',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildMessageCard(
                context,
                avatarColor: Color(0xFFCA771A),
                name: 'Lucban Farmers',
                message: 'Meron pa bang available na',
                time: formattedDateTime,
              ),
              SizedBox(height: 20.0), // Increase spacing between cards
              _buildMessageCard(
                context,
                avatarColor: Color(0xFFCA771A),
                name: 'Farmers Name',
                message: 'Meron pa bang available na',
                time: formattedDateTime,
              ),
              SizedBox(height: 20.0), // Increase spacing between cards
              _buildMessageCard(
                context,
                avatarColor: Color(0xFFCA771A),
                name: 'Farmers Name',
                message: 'Meron pa bang available na coffee beans',
                time: formattedDateTime,
              ),
              // Add more message cards as needed
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a message card
  Widget _buildMessageCard(
    BuildContext context, {
    required Color avatarColor,
    required String name,
    required String message,
    required String time,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Increase padding for larger card size
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: avatarColor,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: avatarColor,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.0,
                      color: avatarColor,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
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