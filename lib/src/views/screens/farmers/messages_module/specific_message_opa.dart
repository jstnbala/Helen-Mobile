// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SpecificMessageOPA extends StatefulWidget {
  const SpecificMessageOPA({super.key});

  @override
  _SpecificMessageOPAState createState() => _SpecificMessageOPAState();
}

class _SpecificMessageOPAState extends State<SpecificMessageOPA> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.insert(0, message); // Insert the new message at the top
      });
      _messageController.clear();
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          0.0, // Scroll to the top
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'OPA Quezon Super Admin',
              style: TextStyle(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              reverse: true, // This makes the list view start from the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCA771A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _messages[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
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
