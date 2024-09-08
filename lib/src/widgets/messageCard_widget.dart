import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:helen_app/src/services/get_user_to_chat.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';

class MessageCard extends StatefulWidget {
  final String receiverId;
  final String message;

  const MessageCard({
    Key? key,
    required this.receiverId,
    required this.message,
  }) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late Future<Map<String, String>> _userToChatDetails;

  @override
  void initState() {
    super.initState();
    final getUserToChatService = GetUserToChatService();
    _userToChatDetails = getUserToChatService.getUserToChatDetailsById(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = DateFormat('MMMM d, yyyy h:mm a').format(DateTime.now());

    return GestureDetector(
      onTap: () async {
        final userToChatDetails = await _userToChatDetails;
        final name = userToChatDetails['FullName'] ?? 'Unknown Admin';
        final profile = userToChatDetails['ProfilePicture'] ?? 'No Profile';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificMessage(
              senderName: name,
              senderId: widget.receiverId,
              senderProfile: profile,
            ),
          ),
        );
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
              FutureBuilder<Map<String, String>>(
                future: _userToChatDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFCA771A),
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFCA771A),
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final profilePictureUrl = snapshot.data!['ProfilePicture'] ?? '';
                     return CircleAvatar(
                    radius: 20,
                    backgroundImage: profilePictureUrl.isNotEmpty
                        ? NetworkImage(profilePictureUrl)
                        : null,
                    backgroundColor: profilePictureUrl.isNotEmpty
                        ? Colors.transparent
                        : Color(0xFFCA771A),
                    child: profilePictureUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24.0,
                          )
                        : null,
                  );
                  } else {
                    return const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFCA771A),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Map<String, String>>(
                      future: _userToChatDetails,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFCA771A),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error loading name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFCA771A),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!['FullName'] ?? 'Unknown Admin',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFCA771A),
                            ),
                          );
                        } else {
                          return const Text(
                            'Unknown Admin',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFCA771A),
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      formattedDateTime,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                    Text(
                      widget.message,
                      style: const TextStyle(
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
