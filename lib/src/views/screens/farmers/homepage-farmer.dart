import 'package:flutter/material.dart';
import 'package:helen_app/src/utils/check_account_verification.dart';
import 'package:helen_app/src/views/screens/farmers/agrikachat_module/agrikachat.dart';
import 'package:helen_app/src/views/common/navbar.dart';
import 'package:helen_app/src/views/screens/farmers/listofproducts_module/product-list.dart';
import 'package:helen_app/src/views/screens/farmers/projects_module/project_screen.dart';
import 'package:helen_app/src/views/screens/farmers/upcoming_events_module/upcoming-events.dart';
import 'package:helen_app/src/services/api_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePageFarmer extends StatefulWidget {
  const HomePageFarmer({super.key});

  @override
  _HomePageFarmerState createState() => _HomePageFarmerState();
}

class _HomePageFarmerState extends State<HomePageFarmer> {
  List<Event> _events = [];
  List<dynamic> _projects = [];
  int _currentPage = 0;
  bool _isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true; // Set loading to true at the start of data fetch
    });
    
    List<Event> events = await fetchUpcomingEvents();
    List<dynamic> projects = await fetchProjects();
    
    setState(() {
      _events = events;
      _projects = projects;
      _isLoading = false; // Set loading to false once data is fetched
    });
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Skeletonizer(
              enabled: true,
              child: _buildSkeletonContent(),
            )
          : RefreshIndicator(
              onRefresh: _fetchData, // Pull-to-refresh triggers _fetchData
              child: _buildMainContent(context),
            ),
    );
  }


  Widget _buildSkeletonContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Skeletonizer(
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Center(
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: List.generate(5, (index) {
                return Skeletonizer(
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 30),
          Skeletonizer(
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMainContent(BuildContext context) {
  return Container(
    color: const Color(0xFFF5F5F5),
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(), // Allow pull-to-refresh even if not scrollable
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            ProjectCard(context: context, projects: _projects),
            const SizedBox(height: 15),
            // First Row with 3 cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute cards evenly
              children: [
                Expanded(
                  child: _buildSquareCard(
                    context,
                    icon: Icons.shopping_cart,
                    label: 'Orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavBar(initialIndex: 2),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10), // Space between cards
                Expanded(
                  child: _buildSquareCard(
                    context,
                    icon: Icons.list,
                    label: 'List of Products',
                    onTap: () {
                      checkAccountVerification(context, onVerified: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductListFarmer()),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10), // Space between cards
                Expanded(
                  child: _buildSquareCard(
                    context,
                    icon: Icons.chat,
                    label: 'AgriKaChat',
                    onTap: () {
                      checkAccountVerification(context, onVerified: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatAI()),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Second Row with 2 cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute cards evenly
              children: [
                Expanded(
                  child: _buildSquareCard(
                    context,
                    icon: Icons.event,
                    label: 'Upcoming Events',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpcomingEvents()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10), // Space between cards
                Expanded(
                  child: _buildSquareCard(
                    context,
                    icon: Icons.note,
                    label: 'Projects',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProjectScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            _buildEventSlider(),
            const SizedBox(height: 55),
          ],
        ),
      ),
    ),
  );
}





Widget _buildEventSlider() {
  if (_events.isEmpty) {
    return const SizedBox(
      height: 140,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  final int itemsPerPage = 3;
  final int pageCount = (_events.length / itemsPerPage).ceil();

  return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start

    children: [
      // Title for Upcoming Events
      
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10), // Add some vertical padding
        child: Text(
          'Featured Events',
          style: TextStyle(
            fontSize: 20, // Font size for the title
            fontWeight: FontWeight.bold, // Make it bold
            color: Colors.black, // Title color
          ),
        ),
      ),
      SizedBox(
        height: 140,
        child: PageView.builder(
          itemCount: pageCount,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, pageIndex) {
            final startIndex = pageIndex * itemsPerPage;
            final endIndex = (startIndex + itemsPerPage <= _events.length)
                ? startIndex + itemsPerPage
                : _events.length;

            final pageItems = _events.sublist(startIndex, endIndex);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: pageItems.map((event) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildEventImage(event.photo, event.title, event.location),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.black : Colors.grey,
            ),
          );
        }),
      ),
    ],
  );
}


  Widget _buildEventImage(String imageUrl, String title, String location) {
    const double imageHeight = 80; // 2/5 of the card height for the image
    const double bottomContainerHeight = 60; // 3/5 of the card height for the bottom container

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            height: imageHeight,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            constraints: const BoxConstraints(
              maxHeight: bottomContainerHeight,
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  location,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildSquareCard(BuildContext context,
    {required IconData icon, required String label, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Expanded(  // Ensure it expands to take all available space
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.3,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure the column takes minimal space
                  mainAxisAlignment: MainAxisAlignment.center, // Align the children vertically centered
                  crossAxisAlignment: CrossAxisAlignment.center, // Align the children horizontally centered
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: const Color(0xFFCA771A), // Icon color
                    ),
                    const SizedBox(height: 8), // Spacing between icon and label
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}


  // New ProjectCard widget to display the first project
Widget ProjectCard({required BuildContext context, required List<dynamic> projects}) {
  if (projects.isEmpty) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: const Text(
        'No projects available',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ); // Display a message if no projects are available
  }

  final firstProject = projects.first; // Get the first project
  final projectImage = firstProject['projectPic'] ?? ''; // Get the project image
  final projectTitle = firstProject['title'] ?? ''; // Get the project title

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectScreen()),
      );
    },
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background image
            Image.network(
              projectImage,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            // Left colored background
            Positioned.fill(
              left: 0,
              child: ClipPath(
                clipper: LeftCurveClipper(),
                child: Container(
                  color: const Color(0xFFCA771A), // Your desired color
                ),
              ),
            ),
            // Title for Featured Project
            const Positioned(
              left: 16,
              top: 8, // Adjust position as needed
              child: Text(
                'Featured Project',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            // Title on the left side
            Positioned(
              left: 16,
              top: 30, // Adjust position to place below the "Featured Project" title
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
                child: Text(
                  projectTitle,
                  maxLines: 2, // Allow up to 2 lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                  softWrap: true, // Allow text to wrap
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


}

// Custom clipper to create a curved effect

// Custom clipper to create a curved effect
class LeftCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.5, 0); // Straight line to the midpoint
    path.quadraticBezierTo(
      size.width * 0.7, // Control point x
      size.height * 0.5, // Control point y
      size.width * 0.5, // End point x
      size.height, // End point y
    );
    path.lineTo(0, size.height); // Line to the bottom left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}