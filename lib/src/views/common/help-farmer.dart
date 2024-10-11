// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/faqs_buyer.dart';
import 'package:helen_app/src/views/common/faqs_farmer.dart';

class HelpFarmerScreen extends StatelessWidget {
  const HelpFarmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered Bold Big Text
              const Text(
                "Are you a Farmer or a Buyer looking for assistance?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Centered Not Bold Small Text
              const Text(
                "Choose the category that best describes your needs:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFCA771A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // Farmer Option with Text on the Left and Image on the Right
              Row(
                children: [
                  const Flexible(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 40.0,
                          color: Color(0xFFCA771A),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bold Big Text beside the Icon
                              Text(
                                "I’m a Farmer",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              SizedBox(height: 5),

                              // Justified Not Bold Small Text beside the Icon
                              Text(
                                "If you’re here to get support for your farmer account, product listings, or event listings, click the image option on the right.",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 107, 107, 107),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Farmer Image with Border and Click Navigation on the Right
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FAQsFarmer()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFCA771A),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0), // Adding Border Radius
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Same Radius for Image
                        child: Image.asset(
                          'images/Help Farmer.png',
                          height: 150.0,
                          width: 150.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Buyer Option with Text on the Left and Image on the Right
              Row(
                children: [
                  const Flexible(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 40.0,
                          color: Color(0xFFCA771A),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bold Big Text beside the Icon
                              Text(
                                "I’m a Buyer",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                              SizedBox(height: 5),

                              // Justified Not Bold Small Text beside the Icon
                              Text(
                                "If you need help with finding products, placing orders, or managing your buyer account, click the image option on the right.",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 107, 107, 107),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Buyer Image with Border and Click Navigation on the Right
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FAQsBuyer()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFCA771A),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0), // Adding Border Radius
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Same Radius for Image
                        child: Image.asset(
                          'images/Help Buyer.png',
                          height: 150.0,
                          width: 150.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
           const SizedBox(height: 10),

              // Gray Divider
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              const SizedBox(height: 10),

              // Footer Text and Email Contact
              const Center(
                child: Text(
                  "For direct support, feel free to reach out to us:",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFCA771A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 5),

              // Email Contact with Icon
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Color(0xFFCA771A),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  Text(
                    "opa_quezon@yahoo.com",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}