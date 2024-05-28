import 'package:flutter/material.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C7230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        children: [
          buildEventCard(),
          SizedBox(height: 16.0), // Add space between cards
          buildEventCard(),
          SizedBox(height: 16.0), // Add space between cards
          buildEventCard(),
        ],
      ),
    );
  }

 Widget buildEventCard() {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            'images/farmers/sample-event.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Event Name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  'May 24, 2024',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  '10:00 AM',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  'Community Hall',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Handle button tap
            },
          ),
        ],
      ),
    );
  }
}
