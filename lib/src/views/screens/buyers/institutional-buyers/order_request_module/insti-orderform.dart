// ignore_for_file: file_names, library_private_types_in_public_api, use_key_in_widget_constructors

// order_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helen_app/src/views/screens/buyers/institutional-buyers/order_request_module/price_breakdown.dart';
import 'package:helen_app/src/services/api_service.dart'; 
import 'package:helen_app/src/services/get_org_products.dart'; // Import your GetOrgProductsAPI

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String? _selectedLocation;
  String _description = ''; // Add a variable to hold the description
  final List<String> _organizations = []; // List to hold organizations
  Map<String, dynamic> _productsFromOrg = {}; // To store products and their details
  final List<Map<String, dynamic>> _products = [
    {'product': null, 'quantity': '', 'price': 0.0},
  ];

  final GetOrgProductsAPI getOrgProductsAPI = GetOrgProductsAPI(); // Create instance of your API class

   @override
  void initState() {
    super.initState();
    _fetchOrganizations(); // Fetch organizations when the widget initializes
  }

  Future<void> _fetchOrganizations() async {
    final organizations = await fetchOrganizations(); // Call your API service
    setState(() {
      _organizations.addAll(organizations); // Add organizations to the list
    });
  }
Future<void> _fetchProductsForOrganization(String organization) async {
  final products = await getOrgProductsAPI.getOrgProducts(organization); // Call to fetch products
  if (products != null) {
    setState(() {
      _productsFromOrg = {
        for (var product in products)
          if (product['productName'] != null && product['unit'] != null && product['price'] != null)
            product['productName']: {
              'unit': product['unit'],
              'price': product['price']
            }
      }; // Store product name as key, and unit and price as a map
    });
  }
}


  void _addProduct() {
    if (_products.length < 10) {
      setState(() {
        _products.add({'product': null, 'quantity': '', 'price': 0.0});
      });
    }
  }

  void _removeProduct(int index) {
    if (_products.length > 1) {
      setState(() {
        _products.removeAt(index);
      });
    }
  }

  bool _validateFields() {
    if (_selectedLocation == null) return false;
    if (_description.isEmpty) return false; // Check if description is not empty
    for (var product in _products) {
      if (product['product'] == null || product['quantity'] == '') return false;
      final quantity = int.tryParse(product['quantity']);
      if (quantity == null || quantity <= 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Form',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Organization',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                   const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      hint: const Text(
                        'Select an Organization',
                        style: TextStyle( 
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      ),
                      value: _selectedLocation,
                      items: _organizations.map((organization) {
                        return DropdownMenuItem(
                          value: organization,
                          child: Text(organization),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                          _fetchProductsForOrganization(value!); // Fetch products for selected organization

                        });
                      },
                      validator: (value) =>
                          value == null ? 'Organization is required' : null,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Color(0xFFCA771A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                      ),          
                    ),
                        // Add the multiline TextField for Description
                    const SizedBox(height: 16.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      maxLines: 4, // Allow for multiple lines
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _description = value; // Update the description
                        });
                      },
                    ),

                    
                    const SizedBox(height: 16.0),
                    ..._products.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Product ${index + 1} Request',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCA771A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text(
                                      'Select a Product',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    value: _products[index]['product'],
                                    items: _productsFromOrg.keys.map((product) {
                                      return DropdownMenuItem(
                                        value: product,
                                        child: Text(product),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _products[index]['product'] = value;
                                        _products[index]['unit'] = _productsFromOrg[value]?['unit'] ?? ''; // Update unit
                                        _products[index]['price'] = _productsFromOrg[value]?['price'] ?? 0.0; // Update price
                                        _products[index]['quantity'] = ''; // Reset quantity
                                      });
                                    },
                                    validator: (value) =>
                                        value == null ? 'Product is required' : null,
                                    decoration: InputDecoration(
                                      labelText: 'Product',
                                      labelStyle: const TextStyle(
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                          fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFCA771A),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFCA771A)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFCA771A)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Quantity',
                                      labelStyle: const TextStyle(
                                          color: Color(0xFFCA771A),
                                          fontFamily: 'Poppins',
                                          fontSize: 14),
                                      suffixText: 'kg',
                                      suffixStyle: const TextStyle(
                                        color: Color(0xFFCA771A),
                                        fontFamily: 'Poppins',
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFCA771A),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFCA771A)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFCA771A)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _products[index]['quantity'] = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Quantity is required';
                                      }
                                      final quantity = int.tryParse(value);
                                      if (quantity == null || quantity <= 0) {
                                        return 'Invalid quantity';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                if (index > 0)
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Color(0xFFCA771A)),
                                    onPressed: () {
                                      _removeProduct(index);
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  TextButton(
                      onPressed: _addProduct,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
                        child: Text(
                          '+ Add More Products',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:  Color(0xFFCA771A), 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PriceBreakdownScreen(
                        location: _selectedLocation!,
                        products: _products,
                        description: _description,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Missing Fields'),
                      content: const Text(
                          'Please fill out all required fields before proceeding.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCA771A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                child: Text(
                  'Proceed to Next',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
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
