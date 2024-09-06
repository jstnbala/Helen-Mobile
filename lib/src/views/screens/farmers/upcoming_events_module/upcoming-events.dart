// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/api_service.dart'; // Import your service where `fetchUpcomingEvents` is defined
import 'dart:convert'; // For base64 decoding
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/specific-event.dart'; // Import the SpecificEvent widget
import 'package:intl/intl.dart'; // For date formatting

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = fetchUpcomingEvents(); // Fetch events when the widget is initialized
  }

  // Helper method to format the date
  String formatDate(String dateStr) {
    final DateTime parsedDate = DateTime.parse(dateStr);
    return DateFormat('MMMM d, yyyy').format(parsedDate);
  }

  // Helper method to format the time
  String formatTime(String dateStr) {
    final DateTime parsedTime = DateTime.parse(dateStr);
    return DateFormat('h:mm a').format(parsedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading events: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No upcoming events found.'));
          } else {
            // When events are successfully loaded
            final events = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];

                // Decode the base64 image
                final bytes = base64Decode(event.photo.split(',')[1]);

                return GestureDetector(
                  onTap: () {
                    // Navigate to the SpecificEvent page with the selected event data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecificEvent(event: event),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      height: 200.0, // Increased height of the card
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Event Photo
                              Container(
                                width: 120.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: MemoryImage(bytes),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              // Event details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title, // Event title
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFCA771A),
                                      ),
                                      maxLines: null,  // Allow text to wrap to multiple lines
                                      softWrap: true,  // Enable soft wrapping of text
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, color: Colors.black, size: 16.0),
                                        const SizedBox(width: 8.0),
                                        const Text(
                                          'Start Date: ', // Bold "Start: "
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formatDate(event.startDate), // Format start date
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            maxLines: null,  // Allow text to wrap to multiple lines
                                            softWrap: true,  // Enable soft wrapping of text
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, color: Colors.black, size: 16.0),
                                        const SizedBox(width: 8.0),
                                        const Text(
                                          'End Date: ', // Bold "End: "
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formatDate(event.endDate), // Format end date
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            maxLines: null,  // Allow text to wrap to multiple lines
                                            softWrap: true,  // Enable soft wrapping of text
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, color: Colors.black, size: 16.0),
                                        const SizedBox(width: 8.0),
                                        const Text(
                                          'Time: ', // Bold "Time: "
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formatTime(event.startDate), // Format time from start date
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            maxLines: null,  // Allow text to wrap to multiple lines
                                            softWrap: true,  // Enable soft wrapping of text
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.black, size: 16.0),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Location:\n', // Bold "Location:"
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: event.location, // Location value
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            maxLines: null,  // Allow text to wrap to multiple lines
                                            softWrap: true,  // Enable soft wrapping of text
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
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
