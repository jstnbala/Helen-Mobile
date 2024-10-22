// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:helen_app/src/context/socket_context.dart';
import 'package:helen_app/src/services/get_admin.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';

class ChatSupport extends StatefulWidget {
  const ChatSupport({super.key});

  @override
  _ChatSupportState createState() => _ChatSupportState();
}

class _ChatSupportState extends State<ChatSupport> {
  String adminName = '';
  String adminId = '';
  String adminProfile = '';

  Future<void> findAdmin(BuildContext context, String role ) async {
    final onlineUsers = useOnlineUsers(context); // Access online users here

    if (onlineUsers.isEmpty) {
      print('No online users available.');
      return; // Early exit if no users are available
    }

    final adminData = await getAdminForSupport(onlineUsers, role);

    if (adminData != null) {
      // Assuming adminData is an object with fields: name, id, and profile
      setState(() {
        adminName = adminData['FullName']; // Set the admin name
        adminId = adminData['_id'];     // Set the admin ID
        adminProfile = adminData['ProfilePicture']; // Set the admin profile
      });
      print("Admin found: $adminData");
    } else {
      // Handle the case where no admin was found
      print("No admin found for the provided IDs.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Call findAdmin when the button is pressed or a specific event occurs
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
              const Text(
                "Choose which admin can attend to your problem",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFCA771A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  await findAdmin(context, 'OPA');
                  
                  if (mounted && adminName.isNotEmpty && adminId.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecificMessage(
                          senderName: adminName,
                          senderId: adminId,
                          senderProfile: adminProfile,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Provincial Agri Admin',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
                 const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  await findAdmin(context, 'Organization-Admin');
                  
                  if (mounted && adminName.isNotEmpty && adminId.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecificMessage(
                          senderName: adminName,
                          senderId: adminId,
                          senderProfile: adminProfile,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Farmer Coop Admin',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
