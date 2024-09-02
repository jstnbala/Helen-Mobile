// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Color(0xFFCA771A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48), // Placeholder to balance the center text
                ],
              ),
            ),
            SizedBox(height: 40),

            // Forgot Password Icon
            Icon(
              Icons.lock_outline,
              size: 100,
              color: Color(0xFFCA771A),
            ),
            SizedBox(height: 20),

            // Info Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Your new password must be different from previously used passwords.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Form with New Password and Confirm Password Fields
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // New Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_showNewPassword,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'Enter your new password',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showNewPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _showNewPassword = !_showNewPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'New Password is required';
                        }
                        if (value.length < 8) {
                          return 'New Password must be at least 8 characters long';
                        }
                        if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
                          return 'New Password must include at least one uppercase \n letter';
                        }
                        if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
                          return 'New Password must include at least one lowercase \n letter';
                        }
                        if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
                          return 'New Password must include at least one number';
                        }
                        if (!RegExp(r'(?=.*?[!@#\$%\^&*()_+\-=\{\}\[\]|:;\"<>,.?/])').hasMatch(value)) {
                          return 'New Password must include at least one special \n character';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Confirm Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_showConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        hintText: 'Re-enter your new password',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm New Password is required';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),

                  // Reset Password Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFCA771A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle reset password logic here
                        }
                      },
                      child: Center(
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Added bottom spacing
          ],
        ),
      ),
    );
  }
}
