// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:helen_app/src/services/api_service.dart';
import 'package:helen_app/src/views/common/login.dart';

class BuyerRegistrationPage extends StatefulWidget {
  const BuyerRegistrationPage({super.key});

  @override
  _BuyerRegistrationPageState createState() => _BuyerRegistrationPageState();
}

class _BuyerRegistrationPageState extends State<BuyerRegistrationPage> {
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactnoController = TextEditingController(text: '+63');

  bool _isLoading = false;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _selectedAccountType;
  String? _businessPermitFileName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPrivacyNotice();
    });
  }

  void _showPrivacyNotice() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Privacy Notice',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "We are committed to safeguarding your privacy and ensuring compliance with the Philippine Data Privacy Act of 2012. When you register, we collect personal information. We also gather usage data, and we use this information to create and manage your account, enhance your experience, communicate updates, and maintain app security. We may share your data with service providers to help operate our app and with legal authorities if required by law. You have the right to access, update, or request the deletion of your information and to opt out of marketing communications. We employ security measures to protect your data but cannot guarantee complete security. By registering, you consent to our data practices under the Data Privacy Act. If you have any questions, please contact us at opa_quezon@yahoo.com.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF606060),
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
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
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
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

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _businessPermitFileName = result.files.single.name;
      });
    }
  }

  String get _accountTypeMessage {
    switch (_selectedAccountType) {
      case 'Direct Buyer':
        return 'Suitable for smaller order quantities that can be fulfilled by individual farmers.';
      case 'Institutional Buyer':
        return 'Designed for larger orders requiring special requests and coordination.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Buyer Registration',
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
      body: GestureDetector(
        onTap: () {
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins'),
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
                const SizedBox(height: 10),

                // Full Name field
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name / Business Name',
                    hintText: 'Enter your full name / business name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name / Business Name is required';
                    }
                    if (value.length > 30) {
                      return 'Should not exceed 30 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Address field
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address / Business Address',
                    hintText: 'Enter your address / business address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins'),
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
                const SizedBox(height: 10),

                // Contact field
                 TextFormField(
                  controller: _contactnoController,
                  decoration: InputDecoration(
                    labelText: 'Contact No.',
                    hintText: 'Enter your contact number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
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
                      _contactnoController.text = '+63';
                      _contactnoController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _contactnoController.text.length),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Business Permit field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Business Permit',
                    hintText: _businessPermitFileName ?? 'Upload your business permit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.upload_file,
                        color: Color(0xFFCA771A),
                      ),
                      onPressed: _pickFile,
                    ),
                  ),
                  readOnly: true,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 10),

                // Account Type field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Account Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        ),
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      style: const TextStyle(fontFamily: 'Poppins'),
                      value: _selectedAccountType,
                      items: ['Direct Buyer', 'Institutional Buyer']
                          .map((type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type, style: const TextStyle(color: Colors.black)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAccountType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an account type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0), // Add spacing between dropdown and message
                    Text(
                      _accountTypeMessage,
                      style: const TextStyle(color: Color(0xFFCA771A), fontSize: 13.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: _isPasswordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
                      return 'Password must include at least one uppercase letter';
                    }
                    if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
                      return 'Password must include at least one lowercase letter';
                    }
                    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
                      return 'Password must include at least one number';
                    }
                    if (!RegExp(r'(?=.*?[!@#\$%\^&*()_+\-=\{\}\[\]|:;\"<>,.?/])').hasMatch(value)) {
                      return 'Password must include at least one special character';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Confirm Password field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                   ),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: _isConfirmPasswordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  style: const TextStyle(fontFamily: 'Poppins'),
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
                const SizedBox(height: 20),

                // Register Button
                ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      final success = await registerBuyer(
                        username: _usernameController.text,
                        fullName: _fullNameController.text,
                        address: _addressController.text,
                        contactNo: _contactnoController.text,
                        accountType: _selectedAccountType ?? '',
                        password: _passwordController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration Successful'),
                            backgroundColor: Colors.green, 
                          ),
                        );
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()), // Replace with your actual LoginPage class
                      );
                        // Navigate to another page or perform another action
                     } else {
                              // If registration fails, show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registration failed. Please try again.'),
                                  backgroundColor: Colors.red, 
                                ),
                              );
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCA771A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
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
    _contactnoController.dispose();
    super.dispose();

  }
}

