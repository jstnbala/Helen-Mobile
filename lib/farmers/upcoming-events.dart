import 'package:flutter/material.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
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
          buildEventCard(
            imageUrl: 'images/farmers/Kadiwa.png',
            title: 'Kadiwa ng Pangulo',
            date: 'June 24, 2024',
            time: '10:00 AM - 12:00 PM',
            location: 'Community Hall',
            description: ' Kadiwa ng Pangulo event, a special gathering dedicated to empowering our hardworking farmers. This event is designed to provide you with the tools and knowledge to enhance your agricultural practices, improve market access.',
          ),
          SizedBox(height: 16.0), // Add space between cards
          buildEventCard(
            imageUrl: 'images/farmers/Skills.png',
            title: 'Skills Training on Herbal Tea Processing',
            date: 'June 16, 2024',
            time: '6:00 AM - 5:00 PM',
            location: 'Quezon Food and Herbal Processing Center',
            description: 'Join us at the Quezon Food and Herbal Processing Center for an exciting and informative event dedicated to empowering our local farmers. Discover innovative food processing techniques, explore herbal product development, and gain valuable insights into sustainable farming practices. .',
          ),
          SizedBox(height: 16.0), // Add space between cards
          buildEventCard(
            imageUrl: 'images/farmers/Cocolym.png',
            title: '2024 Cocolympics',
            date: 'July 28, 2024',
            time: '8:00 AM - 10:00 AM',
            location: 'Lucena Capitol Compound',
            description: 'This years Cocolympics will bring together farmers, producers, industry experts, and coconut enthusiasts from around the world for a series of exciting competitions, exhibitions, and workshops. .',
          ),
        ],
      ),
    );
  }

  Widget buildEventCard({
    required String imageUrl,
    required String title,
    required String date,
    required String time,
    required String location,
    required String description,
  }) {
    return EventCard(
      imageUrl: imageUrl,
      title: title,
      date: date,
      time: time,
      location: location,
      description: description,
    );
  }
}

class EventCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;

  EventCard({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  widget.imageUrl,
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
                        widget.title,
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
                        widget.date,
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
                        widget.time,
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
                        widget.location,
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  '>',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          if (_isExpanded)
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                widget.description,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
