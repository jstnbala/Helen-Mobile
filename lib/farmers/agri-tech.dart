// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class AgriTechnician extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C7230), // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Border radius for lower left corner
            bottomRight: Radius.circular(20.0), // Border radius for lower right corner
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back when the button is pressed
          },
        ),
        title: Text(
          'Agri-Technician',
          style: TextStyle(
            color: Colors.white, // Text color
            fontFamily: 'Poppins', // Font family
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: [
                _buildMessage(isMe: false, name: 'Nestor Matimatico', message: 'Magandang araw, mayroon po akong ilang tanong tungkol sa aking sakahan.', context: context),
                _buildMessage(isMe: true, name: 'Agri Technician', message: 'Sigurado po! handa akong makatulong. Ano pong mga tanong ninyo?', context: context),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Color(0xFF0C7230)), // Camera icon
                  onPressed: () {
                    // Add functionality for camera icon onPressed
                  },
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey[200], // Light gray background color
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type here...', // Hint text
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins', // Font family
                        ),
                        border: InputBorder.none, // No border
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF0C7230)), // Send icon
                  onPressed: () {
                    // Add functionality for send icon onPressed
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({required bool isMe, required String name, required String message, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: isMe
            ? CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.person, color: Colors.white),
              )
            : null,
        title: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue[200], // Light gray or blue background color
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: isMe ? Colors.black : Colors.black,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Poppins',
                  color: isMe ? Colors.black : Colors.black,
                ),
              ),
            ],
          ),
        ),
        trailing: !isMe
            ? CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              )
            : null,
        tileColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        onTap: () {
          // Add functionality for tapping the message if needed
        },
      ),
    );
  }
}
