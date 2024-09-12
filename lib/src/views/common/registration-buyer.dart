// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:helen_app/src/views/common/otp-page.dart';

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
  
  bool _isLoading = false;

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'PH');

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _selectedAccountType;
  String? _businessPermitFileName;
  File? _businessPermitFile;

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
              "We prioritize your privacy and comply with the Philippine Data Privacy Act of 2012. We collect personal and usage data to manage your account, improve your experience, and maintain security. We may share data with service providers and legal authorities if required. You can access, update, or delete your information and opt out of marketing. While we use security measures, complete protection can't be guaranteed. By registering, you agree to our data practices. Contact us at opa_quezon@yahoo.com for any questions.",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF606060),
                fontSize: 14.0,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFCA771A), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    child: const Text(
                      'No I dont',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFCA771A), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    child: const Text(
                      'Yes I do',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                      ),
                    ),
                  ),
                ],
              ),
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
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null && result.files.isNotEmpty) {
    setState(() {
      _businessPermitFile = File(result.files.single.path!);
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
                    hintText: 'e.g: aliah_trader / chowking12',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                    hintText: 'e.g: Aliah Trader / Chowking Quezon',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                    hintText: 'e.g: Sairaya Highway Quezon',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber phone) {
                  print('Phone number changed: ${phone.phoneNumber}');
                },
                onSaved: (PhoneNumber phone) {
                  _phoneNumber = phone;
                  print('Phone number saved: ${_phoneNumber.phoneNumber}');
                },
                initialValue: _phoneNumber,
                inputDecoration: InputDecoration(
                  labelText: 'Contact No.',
                  hintText: 'e.g: 936 655 6033',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                  ),
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                ),
                countries: const ['PH'],
              ),
                const SizedBox(height: 10),

                // Business Permit field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Business Permit',
                    hintText: _businessPermitFileName ?? 'Upload your business permit',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 180, 180), // Setting the hint text color to #D3D3D3
                      fontFamily: 'Poppins',
                    ),
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
                      _formKey.currentState!.save();

                      setState(() {
                        _isLoading = true;
                      });

                      // Create a Map to hold the registration data
                      final registrationData = {
                        'username': _usernameController.text,
                        'fullName': _fullNameController.text,
                        'address': _addressController.text,
                        'contactNo': _phoneNumber.phoneNumber ?? '',
                        'accountType': _selectedAccountType ?? '',
                        'password': _passwordController.text,
                      };

                      // Navigate to the OTP page and pass the registration data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpPage(
                            registrationData: registrationData,
                             modeOfServiceData: {},  // Add the appropriate service data here if needed
                            businessPermitFile: _businessPermitFile, 
                            type: 'buyer', // Assuming the business permit file is the imageFile
                          ),
                        ),
                      );

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
    
    super.dispose();

  }
}

