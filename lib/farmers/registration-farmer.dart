import 'package:flutter/material.dart';

class FarmerRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                    // Validate phone number format using regex
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Password field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // Add additional validation if needed
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
                      icon: Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(fontFamily: 'Poppins'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    // Add additional validation if needed (e.g., match with password)
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
