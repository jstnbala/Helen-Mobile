import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? selectedInventory;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            backgroundColor: Color(0xFFCA771A),
            elevation: 0,
            title: Text(
              'Add Product',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
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
                  side: BorderSide(
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
                  child: Container(
                    height: 200, // Adjust as needed
                    child: _image == null
                        ? Center(
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
              SizedBox(height: 20),

              // Product Name
              Text(
                'Product Name',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
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
              SizedBox(height: 10),

              // Selling Price
              Text(
                'Selling Price',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'PHP 0.00',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
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
              SizedBox(height: 10),

              // Pickup Address
              Text(
                'Pickup Address',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  // Add your regex validation here
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Product Details
              Text(
                'Product Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFCA771A),
                ),
              ),
              TextFormField(
                maxLines: 5, // Increased height
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFCA771A),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
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
              SizedBox(height: 10),

              // Inventory
              Text(
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
                      decoration: InputDecoration(
                        hintText: 'Numbers Only',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
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
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      value: selectedInventory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedInventory = newValue as String?;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Unit',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFFCA771A),
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'kilos',
                          child: Text('Kilos'),
                        ),
                        DropdownMenuItem(
                          value: 'tonne',
                          child: Text('Tonne'),
                        ),
                        // Add more items as needed
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Add Button
            ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_image == null) {
                  // Show an error message if the image is not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a product image.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              }
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
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
          title: Text(
            'Select Image Source',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
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
              child: Text(
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
              child: Text(
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
