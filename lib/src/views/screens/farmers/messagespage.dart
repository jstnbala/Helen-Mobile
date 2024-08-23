// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String _selectedButton = 'Buyer';

  void _onButtonPressed(String buttonName) {
    setState(() {
      _selectedButton = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed('Buyer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButton == 'Buyer' ? Color(0xFFCA771A) : Colors.white,
                      side: BorderSide(
                        color: _selectedButton == 'Buyer' ? Colors.transparent : Color(0xFFCA771A),
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'BUYER',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: _selectedButton == 'Buyer' ? Colors.white : Color(0xFFCA771A),
                        fontSize: 14.0, // Adjust font size if needed
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed('Farmer Orgs'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButton == 'Farmer Orgs' ? Color(0xFFCA771A) : Colors.white,
                      side: BorderSide(
                        color: _selectedButton == 'Farmer Orgs' ? Colors.transparent : Color(0xFFCA771A),
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'FARMER ORGS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: _selectedButton == 'Farmer Orgs' ? Colors.white : Color(0xFFCA771A),
                        fontSize: 12.5, // Adjust font size if needed
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed('Farmer Support'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButton == 'Farmer Support' ? Color(0xFFCA771A) : Colors.white,
                      side: BorderSide(
                        color: _selectedButton == 'Farmer Support' ? Colors.transparent : Color(0xFFCA771A),
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'CHAT SUPPORT',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: _selectedButton == 'Farmer Support' ? Colors.white : Color(0xFFCA771A),
                        fontSize: 12.5, // Adjust font size if needed
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0), // Space between buttons and cards
            Expanded(
              child: ListView(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // Increase padding for larger card size
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFCA771A),
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
                                  'Aikhen John F. Patino',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'July 23, 2024 10:32 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'Meron pa bang available na',
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
                  ),
                  SizedBox(height: 20.0), // Increase spacing between cards
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // Increase padding for larger card size
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFCA771A),
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
                                  'Myrna F. Viena',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'July 23, 2024 10:32 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'Meron pa bang available na',
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
                  ),
                  SizedBox(height: 20.0), // Increase spacing between cards
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // Increase padding for larger card size
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFCA771A),
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
                                  'Justin T. Bala',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'July 23, 2024 10:32 AM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    color: Color(0xFFCA771A),
                                  ),
                                ),
                                Text(
                                  'Meron pa bang available na',
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
