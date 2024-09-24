// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/screens/farmers/listofproducts_module/product-list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/services/api_service.dart'; // Ensure to replace with the actual file where addProduct is located

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? selectedInventory;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  // TextEditingControllers for capturing input
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _productDetailsController = TextEditingController();
  final TextEditingController _inventoryController = TextEditingController();

  // Loading state variable
  bool _isLoading = false;


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _productNameController.dispose();
    _sellingPriceController.dispose();
    _productDetailsController.dispose();
    _inventoryController.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        // Show an error message if the image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a product image.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
       }

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // Convert price to a valid format if necessary (e.g., removing PHP sign)
      const storage = FlutterSecureStorage();
      String? farmerName = await storage.read(key: 'FullName');
      String price = _sellingPriceController.text.replaceAll('PHP', '').trim();

      // Check if farmerName is null or empty
      if (farmerName == null || farmerName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Farmer name is missing. Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Call the addProduct method with the form data
      bool success = await addProduct(
        productName: _productNameController.text,
        farmerName: farmerName, // Use the farmerName variable here
        price: price,
        unit: selectedInventory ?? '',
        inventory: _inventoryController.text,
        productPic: _image!, // You might need to encode the image as a base64 string
        productDetails: _productDetailsController.text,
      );


     // Show a success or failure message based on the result
      if (success) {
        // Show the custom success dialog
        _showSuccessDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add product. Please try again.'),
            backgroundColor: Colors.red,
          ),
          );
        }
      } catch (e) {
        // Handle any unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_bag, // Product-related icon
              size: 60.0,
              color: Color(0xFFCA771A),
            ),
              const SizedBox(height: 20.0),
              const Text(
                "Your product has been successfully added. It is currently pending and will be verified by the Admin shortly. Please wait for notification once the verification is complete. Thank you!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color(0xFFCA771A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductListFarmer()),
                  );
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            backgroundColor: const Color(0xFFCA771A),
            elevation: 0,
            title: const Text(
              'Add Product',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Big Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                  side: const BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                ),
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    _showImageSourceDialog();
                  },
                  child: SizedBox(
                    height: 200, // Adjust as needed
                    child: _image == null
                        ? const Center(
                            child: Icon(
                              Icons.cloud_upload,
                              size: 50,
                            ),
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Product Name
              const Text(
                'Product Name',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Selling Price
              const Text(
                'Selling Price',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                controller: _sellingPriceController,
                decoration: InputDecoration(
                  hintText: 'PHP 0.00',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!RegExp(r'^\₱?\d+(\.\d{2})?$').hasMatch(value)) {
                    return 'Enter a valid price (₱0.00)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Product Details
              const Text(
                'Product Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                controller: _productDetailsController,
                maxLines: 5, // Increased height
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Inventory
              const Text(
                'Inventory',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _inventoryController,
                      decoration: InputDecoration(
                        hintText: 'Numbers Only',
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                 Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: selectedInventory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedInventory = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Unit',
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'grams',
                          child: Text('Grams'),
                        ),
                        DropdownMenuItem(
                          value: 'kilos',
                          child: Text('Kilos'),
                        ),
                        DropdownMenuItem(
                          value: 'tonne',
                          child: Text('Tonne'),
                        ),
                        DropdownMenuItem(
                          value: 'pounds',
                          child: Text('Pounds'),
                        ),
                        // Add more items as needed
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a unit';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

             // Add Button
              ElevatedButton(
                onPressed: _isLoading ? null : _addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Decrease font size
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Image Source',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Camera',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text(
                'Gallery',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
