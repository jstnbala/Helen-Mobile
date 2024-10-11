// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FAQsBuyer extends StatefulWidget {
  const FAQsBuyer({super.key});

   @override
  _FAQsBuyerState createState() => _FAQsBuyerState();
}

class _FAQsBuyerState extends State<FAQsBuyer> {
  final Map<int, bool> _expandedStatus = {};

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
          'FAQs List of Buyers',
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             buildFAQCard(
                0,
                "How do I create an account?",
                "Paano ako makakagawa ng account?",
               [
                  "Open the App—Launch the app; the splash screen will appear and then transition to the login page.",
                  "Register—Click on “Register Here” at the bottom to go to the Select Account Type screen. Tap the “Buyer Button” to proceed.",
                  "Personal Information Screen: Fill in the required fields: Username, Full Name / Business Name, Address, Contact Number, Business Permit (upload as a PDF file), Account Type (choose either Direct Buyer or Institutional Buyer)\n\n"
                  "Direct Buyer—Suitable for smaller order quantities that can be fulfilled by individual farmers.\n\n" 
                  "Institutional Buyer—Designed for larger orders requiring special requests and coordination.",
                  "Complete Registration—After filling in all fields, click the “Register” button.",
                  "OTP Verification—Enter the 6-digit code sent to your provided phone number and click “Verify OTP.”",
                  "Confirmation: If successful, a dialog box will appear. Click “Ok,” and you will be redirected to the Login Page to enter your Username and Password.",
                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                1,
                "What should I do if I forget my password?",
                "Ano ang gagawin ko kung makalimutan ko ang aking password?",
              [
                  "Go to the Login Page and click on “Forgot Password.” In the Phone Number screen, enter the phone number used during registration and click “Send me the code.” You’ll be redirected to the OTP Verification Screen..",
                  "In the OTP Verification Screen, enter the 6-digit code sent to you via SMS and click “Verify OTP.” A confirmation message will appear, and clicking “Ok” will take you to the Reset Password Screen.",
                  "Reset Password Screen—Enter your new password in the provided fields for New Password and Confirm New Password. Click “Reset Password.” You will be redirected to the Login Page, where a snack bar message will confirm “Password Successfully Changed.” Now you can log in with your username and new password.",
                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                2,
                "As a direct buyer, where can I browse and purchase agricultural products? ",
                "Bilang isang direct buyer, saan ako maaaring makapag-browse at makabili ng mga produktong agrikultural?",
              [
                  "Log In & Access Marketplace—After logging in, you’ll be redirected to the Homepage/Marketplace. Use the Search Bar to find products or browse through Product Cards below the bar.",
                  "View Product Details: Click on a Product Card to access the Product Details Page, showing Product Information, Farmer Details, and Delivery Options. Choose between:\n\n"
                  "Message—Send a direct message to the farmer.\n\n"
                  "Order—Navigate to the Checkout Page.",
                  "Checkout Page—Select your preferred Delivery and Payment Method. Click “Proceed to Payment.”",
                  "Payment/QRPage— Review here your product summary. If using GCash/Bank Transfer, a QR code will be generated. Download the QR, then click Confirm Payment to see the Payment Complete dialog. For Cash, a note will confirm that payment will occur upon delivery.",
                  "Receipt Page — View your order summary and download the receipt. Once confirmed, the order will move to the Pending Orders section."

                ],
              ),
              const SizedBox(height: 15),
               buildFAQCard(
                3,
                "As an institutional buyer, how can I request an order?",
                "Bilang isang institutional buyer, paano ako makakapag-request ng order?",
              [
                  "Access Order Request — Click the “Order Request” option at the top of the Homepage to go to the Order Form.",
                  "Fill Out the Order Form — Select the Organization, add a description, and input the products and quantities. To add more items, click “Add More Products.”",
                  "Proceed to Price Breakdown — Click “Proceed to Next” to see the total cost of your order.",
                  "Submit Order — Click “Order Request” to place the order. It will be added to your Requested List.",
                  "Assignment & Payment — The admin or OPA will assign your order to a farmer. Once assigned, view the farmer’s details and proceed with payment."

                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                4,
                "What are the delivery and payment options?",
                "Ano ang mga opsyon sa pag-deliver at pagbabayad?",
              [
                  "During the farmer’s registration process, they were able to set their available payment options. There are three options to choose from: Cash, GCash, and Bank Transfer. Here’s a brief explanation of each option:\n\n"
                  "•  Cash Payment: If you select Cash, the payment will be made in person when you meet with the farmer, depending on the chosen mode of delivery (e.g., pick-up at specific location the buyer requested).\n\n"
                  "•	GCash or Bank Transfer: For these digital payment methods, you can pay by scanning the provided QR code. This makes the transaction quick and secure, allowing for a seamless payment process without the need for physical cash.",
                  "When placing an order, you simply need to choose from the available delivery and payment options that the farmer has set up. Before confirming your order, select the preferred options based on what’s available and convenient for both you. Once everything is selected and confirmed, your order will be processed accordingly."

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFAQCard(int index, String question, String translation, List<String> answers) {
    bool isExpanded = _expandedStatus[index] ?? false;

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isExpanded ? const Color(0xFFFCE9D5) : Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedStatus.clear(); // Close all other cards
                    _expandedStatus[index] = !isExpanded; // Open the selected card
                  });
                },
                child: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  size: 40,
                  color: const Color(0xFFCA771A),
                ),
              ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCA771A),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        translation,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 107, 107, 107),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanded Answer Section
        if (isExpanded)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color(0xFFFCE9D5),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: answers.map((answer) {
                  int stepIndex = answers.indexOf(answer) + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "STEP $stepIndex: ",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            answer,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color.fromARGB(255, 107, 107, 107),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
