// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'specific_message_buyer.dart';
import 'specific_message_org.dart';
import 'specific_message_opa.dart';

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
                        fontSize: 14.0,
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
                        fontSize: 12.5,
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
                        fontSize: 12.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: _buildCards(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCards() {
    if (_selectedButton == 'Buyer') {
      return [
        _buildCard('Aliah Trader', 'August 21, 2024 8:00 AM', 'Hinog na po ba itong mangga?'),
      ];
    } else if (_selectedButton == 'Farmer Orgs') {
      return [
        _buildCard('Admin of Organization One', 'July 30, 2024 5:30 PM', 'Hello po pwede po bang magpatulong sa inyo?'),
      ];
    } else if (_selectedButton == 'Farmer Support') {
      return [
        _buildCard('OPA Quezon Super Admin', 'March 20, 2024 11:30 AM', 'Ano pong katanungan ninyo?'),
      ];
    }
    return [];
  }

  Widget _buildCard(String name, String dateTime, String message) {
    return GestureDetector(
      onTap: () {
        if (name == 'Aliah Trader') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpecificMessageBuyer()),
          );
        } else if (name == 'Admin of Organization One') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpecificMessageOrg()),
          );
        } else if (name == 'OPA Quezon Super Admin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpecificMessageOPA()),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                    Text(
                      dateTime,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Color(0xFFCA771A),
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
      ),
    );
  }
}
