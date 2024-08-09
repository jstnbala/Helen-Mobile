// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';

class ChatAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A), // Background color
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
          'AgriKaChat',
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
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40, // Width of the screen minus padding
                  child: Text(
                    'Anong mga katanungan ang nais mong malaman?',
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontFamily: 'Poppins', // Font family
                      fontStyle: FontStyle.italic, // Italic style
                      fontSize: 18.0, // Font size
                    ),
                    textAlign: TextAlign.center, // Center align the text
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0.0),
            child: Text(
              'Pagpipilian',
              style: TextStyle(
                color: Colors.black, // Text color
                fontFamily: 'Poppins', // Font family
                fontWeight: FontWeight.bold, // Bold font weight
                fontSize: 20.0, // Font size
              ),
            ),
          ),
          SizedBox(height: 10.0), // Spacer
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                buildCard(context, 'Ano ang mga pwede itanim ngayong taginit sa Lucban?'),
                buildCard(context, 'Ano ang pinakamainam na oras ng pagtatanim para sa panahon ngayon?'),
                buildCard(context, 'Mga paraan para tiyakin na magandang klase ang gulay?'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Color(0xFFCA771A)), // Camera icon
                  onPressed: () {
                    // Add functionality for camera icon onPressed
                  },
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey[200], // Grey background color
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
                  icon: Icon(Icons.send, color: Color(0xFFCA771A)), // Send icon
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

  Widget buildCard(BuildContext context, String question) {
    return Card(
      color: Color(0xFFCA771A), // Card background color
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: () {
          // Add functionality for card onTap
        },
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Text(
            question,
            style: TextStyle(
              color: Colors.white, // Text color
              fontFamily: 'Poppins', // Font family
              fontSize: 18.0, // Font size
            ),
            textAlign: TextAlign.center, // Center align the text
          ),
        ),
      ),
    );
  }
}
