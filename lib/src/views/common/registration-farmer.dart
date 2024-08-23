// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:helen_app/src/services/api_service.dart';
import 'package:helen_app/src/views/common/login.dart';

class FarmerRegistrationPage extends StatefulWidget {
  const FarmerRegistrationPage({super.key});

  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {

  bool _isLoading = false;

  List<String> _organizations = []; // Initially empty, will be populated via API
  String? _selectedOrganization; // This will hold the selected value

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController(text: '+63');
  final TextEditingController _rsbsaNoController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchOrganizations(); // Call the fetch method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPrivacyNotice();
    });
  }

  Future<void> _fetchOrganizations() async {
  try {
    final organizations = await fetchOrganizations(); // Ensure this matches the correct method
    print('Organizations fetched: $organizations'); // Debug line
    setState(() {
      _organizations = organizations;
    });
  } catch (e) {
    print('Failed to fetch organizations: $e');
  }
}

  void _showPrivacyNotice() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Privacy Notice',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "We are committed to safeguarding your privacy and ensuring compliance with the Philippine Data Privacy Act of 2012. When you register, we collect personal information. We also gather usage data, and we use this information to create and manage your account, enhance your experience, communicate updates, and maintain app security. We may share your data with service providers to help operate our app and with legal authorities if required by law. You have the right to access, update, or request the deletion of your information and to opt out of marketing communications. We employ security measures to protect your data but cannot guarantee complete security. By registering, you consent to our data practices under the Data Privacy Act. If you have any questions, please contact us at opa_quezon@yahoo.com.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF606060),
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'I do not accept',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'I accept',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Farmer Registration',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFCA771A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Unfocus the form when tapping outside of a field
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            30.0,
            30.0,
            30.0,
            MediaQuery.of(context).viewInsets.bottom + 30.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Username field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters long';
                    }
                    if (value.length > 15) {
                      return 'Username should not exceed 15 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Full Name field
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name is required';
                    }
                    if (value.length > 30) {
                      return 'Full Name should not exceed 30 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Address field
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9\s\-,]+$').hasMatch(value)) {
                      return 'Enter a valid address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Organization Dropdown
              DropdownButtonFormField<String>(
              value: _selectedOrganization,
              decoration: InputDecoration(
                labelText: 'Organization',
                hintText: 'Select your organization',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: TextStyle(fontFamily: 'Poppins'),
              ),
              items: _organizations.map((organization) {
                return DropdownMenuItem<String>(
                  value: organization,
                  child: Text(organization),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOrganization = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an organization';
                }
                return null;
              },
            ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _contactNoController,
                  decoration: InputDecoration(
                    labelText: 'Contact No.',
                    hintText: 'Enter your contact number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    // Remove the +63 prefix before validating the remaining digits
                    String contactNumber = value?.replaceFirst('+63', '') ?? '';
                    if (contactNumber.isEmpty) {
                      return 'Contact number is required';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(contactNumber)) {
                      return 'Enter a valid 10-digit contact number';
                    }
                    return null;
                  },
                  // Prevents user from removing the +63 prefix
                  onChanged: (value) {
                    if (!value.startsWith('+63')) {
                      _contactNoController.text = '+63';
                      _contactNoController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _contactNoController.text.length),
                      );
                    }
                  },
                ),

                SizedBox(height: 10),

                // RSBSA No. field
                TextFormField(
                  controller: _rsbsaNoController,
                  decoration: InputDecoration(
                    labelText: 'RSBSA No.',
                    hintText: 'Enter your RSBSA No.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'RSBSA No. is required';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Enter a valid RSBSA No.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: _isPasswordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                      return 'Password must include at least one uppercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                      return 'Password must include at least one lowercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                      return 'Password must include at least one number';
                    }
                    if (!RegExp(r'^(?=.*?[!@#\$%\^&*()_+\-=\{\}\[\]|:;\"\<>,.\?/])').hasMatch(value)) {
                      return 'Password must include at least one special character';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Confirm Password field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: _isConfirmPasswordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Register Button
                ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      final success = await registerFarmer(
                        username: _usernameController.text,
                        fullName: _fullNameController.text,
                        address: _addressController.text,
                        organization: _selectedOrganization ?? '',
                        contactNo: _contactNoController.text,
                        rsbsaNo: _rsbsaNoController.text,
                        password: _passwordController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration Successful'),
                            backgroundColor: Colors.green, 
                          ),
                        );
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your actual LoginPage class
                      );
                        // Navigate to another page or perform another action
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration Failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCA771A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Register',
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _contactNoController.dispose();
    _rsbsaNoController.dispose();
    super.dispose();

  }
}

