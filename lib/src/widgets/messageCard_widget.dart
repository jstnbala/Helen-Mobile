// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_messages_api.dart';
import 'package:helen_app/src/services/get_user_to_chat.dart';
import 'package:helen_app/src/views/screens/messages_module/specific_message.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Import Skeletonizer package

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
  late Future<void> _fetchAllDataFuture;
  Map<String, dynamic> _userToChatDetails = {};
  Map<String, dynamic> _latestMessage = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initiate the data fetching when the card is initialized
    _fetchAllDataFuture = _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      // Fetch user details and messages in parallel
      final getUserToChatService = GetUserToChatService();
      _userToChatDetails =
          await getUserToChatService.getUserToChatDetailsById(widget.receiverId);

      final senderId = _userToChatDetails['_id'] ?? '';
      final api = GetMessagesApi();
      final messagesList = await api.getMessages(senderId);

      // Check if there are any messages and get the last one
      if (messagesList.isNotEmpty) {
        _latestMessage = messagesList.last;
      }

      setState(() {
        _isLoading = false; // Set loading to false once all data is fetched
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Stop loading even in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_userToChatDetails.isNotEmpty) {
          final name = _userToChatDetails['FullName'] ?? 'Unknown Admin';
          final profile = _userToChatDetails['ProfilePicture'] ?? 'No Profile';
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
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isLoading
              ? Skeletonizer(
                  enabled: true,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFCA771A),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 18.0,
                              width: 100.0,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 14.0,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: _userToChatDetails['ProfilePicture'] != null
                          ? NetworkImage(_userToChatDetails['ProfilePicture'])
                          : null,
                      backgroundColor: _userToChatDetails['ProfilePicture'] != null
                          ? Colors.transparent
                          : const Color(0xFFCA771A),
                      child: _userToChatDetails['ProfilePicture'] == null
                          ? const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24.0,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userToChatDetails['FullName'] ?? 'Unknown Admin',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFFCA771A),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _latestMessage.isNotEmpty
                                      ? '${_latestMessage['senderId'] != widget.receiverId ? 'You: ' : ''}${_latestMessage['message']}'
                                      : 'No messages',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (_latestMessage.isNotEmpty)
                                Text(
                                  '${timeago.format(DateTime.parse(_latestMessage['createdAt']))}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
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
