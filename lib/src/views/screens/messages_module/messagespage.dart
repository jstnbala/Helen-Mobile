// ignore_for_file: unused_field, library_private_types_in_public_api, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_conversations_api.dart';
import 'package:helen_app/src/widgets/messageCard_widget.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Import Skeletonizer package

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

  Future<void> _refreshMessages() async {
    await _loadUserIdAndMessages(); // Refresh the messages by calling the load function again
  }

  void _onButtonPressed(String buttonName) {
    setState(() {
      _selectedButton = buttonName;
      _loadUserIdAndMessages();
    });
  }

  Widget _buildSkeletonLoader() {
    return Skeletonizer(
      enabled: true, // Enable skeleton loading
      child: ListView.builder(
        itemCount: 5, // Display 5 skeleton items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshMessages, // Pull to refresh
                child: FutureBuilder<List<dynamic>>(
                  future: _messagesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildSkeletonLoader(); // Show skeleton loader while waiting
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
            ),
          ],
        ),
      ),
    );
  }
}
