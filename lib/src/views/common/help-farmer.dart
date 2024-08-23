// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';

class HelpFarmerScreen extends StatelessWidget {
  const HelpFarmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Help',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Hi, Farmer how may I help you?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              color: Color(0xFFCA771A),
              margin: EdgeInsets.only(top: 8.0), // Adjusted top margin
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Frequently Asked Questions',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    _buildFAQItem(
                      question: 'How can I create an account?',
                      answer: 'What are the steps I need to follow in order to successfully set up a new account on the e-commerce platform?',
                    ),
                    SizedBox(height: 8.0),
                    _buildFAQItem(
                      question: 'Where can I message my Farmer Organization to which I belong?',
                      answer: 'What are the various methods or contact points available for me to send a message or communicate with the Farmer Organization I am a member of?',
                    ),
                    SizedBox(height: 8.0),
                    _buildFAQItem(
                      question: 'If I have questions about my crops, where can I reach out for help?',
                      answer: 'Where can I seek assistance or find answers if I have specific questions or concerns regarding the cultivation or management of my crops?',
                    ),
                    SizedBox(height: 8.0),
                    _buildFAQItem(
                      question: 'Where should I list the products I want to sell?',
                      answer: 'In which section or area of the e-commerce platform should I enter or display the details of the products that I intend to sell?',
                    ),
                    SizedBox(height: 8.0),
                    _buildFAQItem(
                      question: 'Where can I find information about upcoming events?',
                      answer: 'Where can I access details or find announcements about events that are scheduled to take place, relevant to my interests or activities?',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          answer,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.0,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
