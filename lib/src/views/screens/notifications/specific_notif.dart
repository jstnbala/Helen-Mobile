import 'package:flutter/material.dart';
import 'package:helen_app/src/services/get_notifications_api.dart';

class SpecificNotif extends StatelessWidget {
  final Map<String, dynamic> notification;
  final Function onDelete; // Callback function

  const SpecificNotif({
    super.key,
    required this.notification,
    required this.onDelete, // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    final GetNotifications getNotifications = GetNotifications();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification['title'] ?? 'No Title',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFFCA771A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              notification['body'] ?? 'No Body',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xFF878787),
              ),
            ),
            const Spacer(),
            // Delete button at the bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final isDeleted = await getNotifications.deleteNotifications(notification['_id']); // Call delete function

                  // Check if the widget is still mounted
                  if (context.mounted) {
                    if (isDeleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Notification deleted successfully.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      );
                      onDelete(); // Call the callback function to notify the parent
                      Navigator.of(context).pop(); // Go back after deleting
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Failed to delete notification.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
