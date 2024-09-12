
// ignore_for_file: unused_local_variable, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage
import 'package:helen_app/src/services/get_messages_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:helen_app/src/context/socket_context.dart';
import 'package:intl/intl.dart'; // Import the intl package

class SpecificMessage extends StatefulWidget {
  final String senderName;
  final String senderId;
  final String senderProfile;

  const SpecificMessage({
    super.key,
    required this.senderName,
    required this.senderId,
    required this.senderProfile,
  });

  @override
  _SpecificMessageState createState() => _SpecificMessageState();
}

class _SpecificMessageState extends State<SpecificMessage> {
  final TextEditingController _messageController = TextEditingController();
  final List<dynamic> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId().then((_) {
      listenForNewMessages(); // Start listening for new messages after userId is fetched
    });
    fetchMessages();
  }

  Future<void> fetchUserId() async {
    userId = await storage.read(key: 'id');
  }

  Future<void> fetchMessages() async {
    final api = GetMessagesApi();
    try {
      final messagesList = await api.getMessages(widget.senderId);
      setState(() {
        _messages.clear();
        _messages.addAll(messagesList);
        _scrollToBottom(); // Scroll to the bottom after messages are loaded
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void listenForNewMessages() {
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    print('listen for new messages');
    socketProvider.socket?.on("newMessage", (newMessage) {
      if (newMessage['senderId'] == widget.senderId) {
        setState(() {
          _messages.add(newMessage);
          _scrollToBottom();
        });
      }
    });
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      final api = GetMessagesApi();
      try {
        if (userId != null) {
          final response = await api.sendMessages(widget.senderId, message); // Send message to the receiver with the current user's ID
          
          setState(() {
            _messages.add(response); // Add the new message to the end of the list
            _messageController.clear();
            _scrollToBottom();
          });
        } else {
          print('User ID not found');
        }
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
  
  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  String _formatDate(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final formatter = DateFormat('EEEE h:mm a');
    return formatter.format(dateTime);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent); // Scroll to the bottom
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastMessageDateTime;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFFCA771A),
                ),
              ),
            ),
            const SizedBox(width: 10),
               CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 20,
          child: widget.senderProfile.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: widget.senderProfile,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                )
              : const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24.0,
                ),
        ),
            const SizedBox(width: 10),
            Text(
              widget.senderName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              reverse: false, // This makes the list view start from the top
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByUser = message['senderId'] == userId;
                final createdAt = message['createdAt']; // Assuming this is an ISO 8601 string
                final createdAtDateTime = DateTime.parse(createdAt);

                if (index == _messages.length - 1) {
                  lastMessageDateTime = createdAtDateTime;
                }

                bool shouldShowDateTime = false;

                if (index > 0) {
                  final previousMessage = _messages[index - 1];
                  final previousMessageDateTime = DateTime.parse(previousMessage['createdAt']);
                  final difference = createdAtDateTime.difference(previousMessageDateTime);

                  if (difference.inMinutes >= 15) {
                    shouldShowDateTime = true;
                  }
                }

                return Row(
                  mainAxisAlignment: isSentByUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!isSentByUser)
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(widget.senderProfile), // Cached network image
                        radius: 20,
                      ),
                    if (!isSentByUser) const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isSentByUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (shouldShowDateTime) // Show date/time in the middle
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  _formatDate(createdAt),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSentByUser
                                  ? const Color(0xFFCA771A)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isSentByUser
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                            ),
                            child: Text(
                              message['message'],
                              style: TextStyle(
                                color: isSentByUser ? Colors.white : Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          if (index == _messages.length - 1) // Display time only for the latest message
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                _formatTimestamp(createdAt),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                 
                  ],
                );
              },
            ),
          ),
          Container(
            color: const Color(0xFFCA771A),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Add a message...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.send,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
