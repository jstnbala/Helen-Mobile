// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_notifications_api.dart'; // Import the GetNotifications class

class FarmerNotifPage extends StatefulWidget {
  const FarmerNotifPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FarmerNotifPageState createState() => _FarmerNotifPageState();
}

class _FarmerNotifPageState extends State<FarmerNotifPage> {
  late Future<List<dynamic>> _notifications;
  List<dynamic> _notificationList = []; // Local copy to manage notifications

  @override
  void initState() {
    super.initState();
    _notifications = GetNotifications().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _notifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              _notificationList = snapshot.data!;
              if (_notificationList.isEmpty) {
                return const Center(
                  child: Text(
                    'No new notifications.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFF878787),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: _notificationList.length,
                  itemBuilder: (context, index) {
                    final notif = _notificationList[index];
                    return _buildNotificationCard(notif, index);
                  },
                );
              }
            } else {
              return const Center(
                child: Text(
                  'No notifications found.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0xFF878787),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif, int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.notifications,
              color: Color(0xFFCA771A),
              size: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notif['body'] ?? 'No Body',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Color(0xFF878787),
                    ),
                  ),
                ],
              ),
            ),
            // Add the 3-circle icon and the popup menu
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Color(0xFFCA771A),
              ),
              onSelected: (String result) {
                if (result == 'remove') {
                  _removeNotification(index);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'remove',
                  child: Text(
                    'Remove this notification',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Poppins font for remove option
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to remove a notification and show an undo option
  void _removeNotification(int index) {
    final removedNotif = _notificationList[index];

    setState(() {
      _notificationList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Notification Removed',
          style: TextStyle(
            fontFamily: 'Poppins', // Poppins font for "Notification Removed"
          ),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,  // Optional: add color to the undo text
          onPressed: () {
            // Undo removal by adding the notification back to the list
            setState(() {
              _notificationList.insert(index, removedNotif);
            });
          },
        ),
      ),
    );
  }
}
