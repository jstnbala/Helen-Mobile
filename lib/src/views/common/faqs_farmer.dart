// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FAQsFarmer extends StatefulWidget {
  const FAQsFarmer({super.key});

  @override
  _FAQsFarmerState createState() => _FAQsFarmerState();
}

class _FAQsFarmerState extends State<FAQsFarmer> {
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
          'FAQs List of Farmers',
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
            children: [
              buildFAQCard(
                0,
                "How do I create an account?",
                "Paano ako makakagawa ng account?",
                [
                  "Opens splash screen upon launching the app, followed by the login page. Click “Register Here” to proceed.",
                  "In Select Account Type, tap the “Farmer Button” to access the Personal Information Screen. Accept the terms and conditions to continue.",
                  "In Personal Information Screen, fill in your Username, Full Name, Address, Organization, Contact Number, RSBSA Number, and Password. Click “Next” to go to the Mode of Services Screen.",
                  "In Mode of Services Screen, indicate your delivery and payment methods, including Farm Location, Mode of Delivery (e.g., pickups), and Payment options (Cash, GCash, Bank Transfer). Click “Next” to continue.",
                  "In Profile Picture Screen, capture a selfie using your camera. Click “Take a Picture” to open the camera interface, align your face, and confirm your photo.",
                  "In OTP Verification, after confirming, you'll receive a 6-digit verification code via SMS. Enter the code and click “Verify OTP.” Once confirmed, a success message will appear.",
                  "Lastly, click “Ok” to finish the process and you're redirected to the Login Page, where you can enter your registered Username and Password."
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
                  "Reset Password Screen—Enter your new password in the provided fields for New Password and Confirm New Password. Click “Reset Password.” You will be redirected to the Login Page, where a snack bar message will confirm “Password Successfully Changed.” Now you can log in with your username and new password."
                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                2,
                "If I have farming-related questions, where can I seek help if I can't go directly to the office?",
                "Kung may mga tanong ako tungkol sa pagsasaka, saan ako makakahingi ng tulong?",
                [
                  "Log In—Access your account and go to the Homepage. Locate the four cards at the bottom of the screen.",
                  "Access AgriKaChat—Tap the last card labeled 'AgriKaChat' to enter the chat interface.",
                  "Type Your Query: Enter your farming-related question in the chatbox. \n\nExamples include: \n —Ano ang pinakamainam na pataba para sa palay? \n —Paano ko maiiwasan ang mga peste?",
                  "Submit Your Question—Press the 'Send' button located at the lower right of the chatbox to submit your query.",
                  "Receive Automated Response—Wait for the AgriKaChat bot to respond with an answer based on your question."
                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                3,
                "Where can I add the agricultural products I want to sell?",
                "Saan ko maaaring idagdag ang mga produktong agrikultural na nais kong ibenta?",
                [
                  "Access Add Products Page—Tap the 'Plus icon' or 'Add button' at the bottom of the navigation bar to go to the Add Products page.",
                  "Upload Product Information—Fill in the required fields such as Product Picture, Product Name, Selling Price, Product Details, Quantity, Unit.",
                  "Submit Product—After completing all fields, click the “Add” button.",
                  "Confirmation Message—Once the loading process is complete, a message will appear stating, “Your product has been successfully added. It is currently pending and will be verified by the admin shortly. Please wait for a notification once the verification is complete. Thank you!” Click “Okay” to proceed.",
                  "View Product Status—You will be redirected to the List of Products screen, where your new product will appear as pending. You will receive a notification when your product is verified or has an ordered status. If verified, it will be listed in the buyer’s marketplace. If it shows an ordered status, your product has been sold.",
                ],
              ),
              const SizedBox(height: 15),
              buildFAQCard(
                4,
                "Can I view events? Where can I find them?",
                "Makikita ko ba ang mga events? Saan ko ito makikita?",
                [
                  "Locate Upcoming Events—Find the “Upcoming Events” card at the bottom section of your Homepage. It appears as the third card.",
                  "View Event List—Click on the Upcoming Events card to see a list of event cards. Each card displays an image on the left and essential details on the right, including the event title, date, time, and location for easy reference.",
                  "Learn More About an Event—To get more information about a specific event, click on the event card. This will take you to the Event Information page.",
                  "Review Event Details—On the Event Information page, you’ll find comprehensive details about the event, including the event picture, name, start and end dates, time, location, and other relevant information.",
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
