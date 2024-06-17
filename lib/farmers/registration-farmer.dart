import 'package:flutter/material.dart';
 
class FarmerRegistrationPage extends StatefulWidget {
  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}
 
class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
 
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
        backgroundColor: Color(0xFF0C7230),
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
                    // Validate username format using regex
                    if (!RegExp(r'^[a-zA-Z0-9_.-]+$').hasMatch(value)) {
                      return 'Enter a valid username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
 
                // Full Name field
                TextFormField(
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
                    // Add any additional specific requirements if needed
                    return null;
                  },
                ),
                SizedBox(height: 10),
 
                // Address field
                TextFormField(
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
                    // Add regex validation if needed
                    // Example: Validate letters, numbers, spaces, commas, and hyphens
                    // Modify the regex pattern as per your specific requirements
                    if (!RegExp(r'^[a-zA-Z0-9\s\-,]+$').hasMatch(value)) {
                      return 'Enter a valid address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
 
                // Organization field (optional)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Organization',
                    hintText: 'Enter your organization (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  // No validator for optional field
                ),
                SizedBox(height: 10),
 
                // Contact field with regex validation
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact',
                    hintText: 'Enter your contact number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: TextStyle(fontFamily: 'Poppins'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number is required';
                    }
                    // Validate contact number format using regex
                    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                      return 'Enter a valid 11-digit contact number';
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
                      icon: _isPasswordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
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
 
                    // Check for minimum length
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
 
                    // Check for uppercase letter
                    RegExp uppercaseRegex = RegExp(r'^(?=.*?[A-Z])');
                    if (!uppercaseRegex.hasMatch(value)) {
                      return 'Password must include at least one uppercase letter';
                    }
 
                    // Check for lowercase letter
                    RegExp lowercaseRegex = RegExp(r'^(?=.*?[a-z])');
                    if (!lowercaseRegex.hasMatch(value)) {
                      return 'Password must include at least one lowercase letter';
                    }
 
                    // Check for digit
                    RegExp digitRegex = RegExp(r'^(?=.*?[0-9])');
                    if (!digitRegex.hasMatch(value)) {
                      return 'Password must include at least one number';
                    }
 
                    // Check for special character
                    RegExp specialCharRegex = RegExp(r'^(?=.*?[!@#\$%\^&*()_+\-=\{\}\[\]|:;\"\<>,.\?/])');
                    if (!specialCharRegex.hasMatch(value)) {
                      return 'Password must include at least one special character';
                    }
 
                    return null; // Return null if the password is valid
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
                      icon: _isConfirmPasswordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
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
                    // Check if the password matches the original password
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
 
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registration Successful'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Perform registration logic here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0C7230),
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
}