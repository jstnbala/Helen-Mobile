import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/buyers/direct-buyers/buyproducts_module/search/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<dynamic> verifiedProductList; // Use a List to pass the verified products

  const SearchScreen({
    Key? key,
    required this.verifiedProductList,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> productNames = []; // Holds product names
  List<String> filteredSuggestions = [];
  bool _isLoading = true; // Tracks loading state

  @override
  void initState() {
    super.initState();
    _initializeProductNames(); // Use the passed verified product list
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Initialize product names from the passed verifiedProductList
  void _initializeProductNames() {
    setState(() {
      productNames = widget.verifiedProductList
          .map<String>((product) =>
              product['ProductName'] as String? ?? 'Unnamed Product')
          .toList();
      filteredSuggestions = productNames; // Initially show all product names
      _isLoading = false;
    });
  }

  // Update filteredSuggestions based on search input
  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      filteredSuggestions = productNames
          .where((productName) => productName.toLowerCase().contains(query))
          .toList();
    });
  }

  // Navigate to the SearchResultScreen with the initial value
  void _navigateToResult(String initialValue) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          verifiedProductList: widget.verifiedProductList,
          initialValue: initialValue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFCA771A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Color(0xFFCA771A)),
          decoration: const InputDecoration(
            hintText: 'Search Here...',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 135, 135, 135),
              fontFamily: 'Poppins',
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFFCA771A),
            ),
          ),
          onSubmitted: (value) {
            // Handle Enter key press
            _navigateToResult(value.isEmpty ? _searchController.text : value);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Show loading spinner
          : filteredSuggestions.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    final productName = filteredSuggestions[index];
                    return ListTile(
                      title: Text(productName),
                      onTap: () {
                        // Handle suggestion selection
                        _navigateToResult(productName);
                      },
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No products found.'),
                      const SizedBox(height: 10),
                     
                    ],
                  ),
                ),
    );
  }
}
