import 'package:flutter/material.dart';
import 'package:helen_app/src/services/api_service.dart';
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/specific-event.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  // Group events by their formatted date
  Map<String, List<Event>> groupEventsByDate(List<Event> events) {
    events.sort((a, b) => DateTime.parse(b.startDate).compareTo(DateTime.parse(a.startDate))); // Sort by latest date first
    Map<String, List<Event>> groupedEvents = {};

    for (var event in events) {
      final formattedDate = formatDate(event.startDate);
      if (!groupedEvents.containsKey(formattedDate)) {
        groupedEvents[formattedDate] = [];
      }
      groupedEvents[formattedDate]!.add(event);
    }

    return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCA771A),
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
            // Group events by date
            final groupedEvents = groupEventsByDate(snapshot.data!);

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: groupedEvents.length,
              itemBuilder: (context, index) {
                final date = groupedEvents.keys.elementAt(index);
                final events = groupedEvents[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header - displaying only once for each group
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    // List of events for this date
                    Column(
                      children: events.map((event) {
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
                              height: 130.0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Event Photo
                                        Container(
                                          width: 120.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(event.photo),
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
                                                event.title,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFCA771A),
                                                ),
                                                maxLines: null,
                                                softWrap: true,
                                              ),
                                              const SizedBox(height: 4.0),
                                              buildEventRow(Icons.access_time, formatTime(event.startDate)),
                                              const SizedBox(height: 4.0),
                                              buildLocationRow(event.location),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildEventRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 16.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            maxLines: null,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget buildLocationRow(String location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.black, size: 16.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            maxLines: null,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
