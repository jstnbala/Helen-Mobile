// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:helen_app/src/services/api_service.dart'; // Import your service where `fetchProjectScreen` is defined
import 'package:helen_app/src/views/screens/farmers/projects_module/specific_projects.dart';
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/specific-event.dart'; // Import the SpecificEvent widget
import 'package:intl/intl.dart'; // For date formatting
import 'package:cached_network_image/cached_network_image.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late Future<List<dynamic>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = fetchProjects(); // Fetch events when the widget is initialized
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
          'Projects',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading projects: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No upcoming projects found.'));
          } else {
            // When projects are successfully loaded
            final projects = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return Listener(
                  onPointerDown: (PointerDownEvent event) {
                    // Only handle tap event
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpecificProjects(project: project),
                        ),
                      );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      height: 130,
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
                                // Project Photo
                                Container(
                                  width: 120.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(project['projectPic']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                // Project details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project['title'], // Project title
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCA771A),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis, // Add ellipsis if text exceeds 2 lines
                                      ),
                                      const SizedBox(height: 4.0),
                                      buildEventRow(Icons.calendar_today, formatDate(project['dateAdded'])),
                                      const SizedBox(height: 4.0),
                                      buildEventRow(Icons.access_time, project['status']),
                                      const SizedBox(height: 4.0),
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
            maxLines: null,  // Allow text to wrap to multiple lines
            softWrap: true,  // Enable soft wrapping of text
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
                  text: location, // Location value
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
    );
  }
}
