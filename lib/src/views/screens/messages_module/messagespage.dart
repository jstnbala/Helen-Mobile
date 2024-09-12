// ignore_for_file: unused_field, library_private_types_in_public_api, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_conversations_api.dart';
import 'package:helen_app/src/widgets/messageCard_widget.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String _selectedButton = 'Buyer';
  late Future<List<dynamic>> _messagesFuture = Future.value([]);
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndMessages();
  }

  Future<void> _loadUserIdAndMessages() async {
    final apiService = GetConversationsApi();
    final userId = await apiService.getUserID();

    setState(() {
      _userId = userId;
      _messagesFuture = userId != null ? apiService.getMessages() : Future.value([]);
    });
  }

  void _onButtonPressed(String buttonName) {
    setState(() {
      _selectedButton = buttonName;
      _loadUserIdAndMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
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
            const SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _messagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No messages found"));
                  } else {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final participantId = message['participants']
                          .firstWhere((participant) => participant != _userId, orElse: () => 'Unknown');
                        final messageText = message['message'] ?? 'No message';

                        return MessageCard(
                          receiverId: participantId,
                          message: messageText,
                          
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
