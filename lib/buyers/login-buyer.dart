// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:helen_app/buyers/nav-bar-buyer.dart';
import 'package:helen_app/buyers/forgot-pass-buyer.dart'; // Import ForgotPassPage class
import 'package:helen_app/buyers/registration-buyer.dart'; // Import BuyerRegistrationPage class

class LoginPageBuyer extends StatefulWidget {
  @override
  _LoginPageBuyerState createState() => _LoginPageBuyerState();
}

class _LoginPageBuyerState extends State<LoginPageBuyer> {
  bool _obscurePassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Expected credentials
  final String _expectedUsername = 'jstn_bala';
  final String _expectedPassword = '@Buying31';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: size.height,
          child: Column(
            children: [
              // Container for the background image and overlay
              Container(
                width: size.width,
                height: size.height * 0.4, // Adjust height to fit header content
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: Image.asset(
                          'images/buyers/buyer-login-bg.jpg',
                          fit: BoxFit.cover, // Make sure the image covers the entire container
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.4, // Adjust height to fit header content
                      decoration: BoxDecoration(
                        color: Color(0xFF0C7230).withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 140, // Adjust height of logo
                                child: Image.asset('images/farmers/white-helen.png'),
                              ),
                              SizedBox(width: 3), // Add some space between the logos
                              SizedBox(
                                height: 140, // Adjust height of logo
                                child: Image.asset('images/farmers/logo-opa.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between logos and text
                        Text(
                          'Welcome, Buyer!',
                          style: TextStyle(
                            fontSize: 28, // Make text bigger
                            fontWeight: FontWeight.bold, // Make text bold
                            color: Colors.white, // Set text color to white
                            fontFamily: 'Poppins', // Set font to Poppins
                          ),
                        ),
                        SizedBox(height: 8), // Add some space between lines
                        Text(
                          'Please log in using your credentials below',
                          style: TextStyle(
                            fontSize: 16, // Make text smaller
                            color: Colors.white, // Set text color to white
                            fontFamily: 'Poppins', // Set font to Poppins
                          ),
                          textAlign: TextAlign.center, // Align text center
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add some space between text and form
              Center(
                child: Container(
                  width: size.width * 0.8, // Set width to 80% of the screen width
                  child: TextField(
                    controller: _usernameController, // Assign the controller
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Increase padding
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      labelStyle: TextStyle(color: Color(0xFF0C7230), fontFamily: 'Poppins'),
                      hintStyle: TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: size.width * 0.8, // Set width to 80% of the screen width
                  child: TextField(
                    controller: _passwordController, // Assign the controller
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Increase padding
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      labelStyle: TextStyle(color: Color(0xFF0C7230), fontFamily: 'Poppins'),
                      hintStyle: TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0), // Set border color and width
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF0C7230), // Set icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                    obscureText: _obscurePassword,
                  ),
                ),
              ),
              SizedBox(height: 8), // Add some space between password field and Forgot Password text
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to ForgotPassPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassBuyer()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0C7230),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Login Button
              Center(
                child: Container(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform login validation
                      String enteredUsername = _usernameController.text.trim();
                      String enteredPassword = _passwordController.text.trim();

                      if (enteredUsername == _expectedUsername && enteredPassword == _expectedPassword) {
                        // Navigate to Navbar on successful login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavbarBuyer()),
                        );
                      } else {
                        // Show error if credentials do not match
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Login Failed'),
                            content: Text('Invalid username or password. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0C7230),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFF0C7230)),
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Additional text below the login button
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Color(0xFF0C7230),
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 4),
              InkWell(
                onTap: () {
                  // Navigate to BuyerRegistrationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuyerRegistrationPage()),
                  );
                },
                child: Text(
                  'Register here',
                  style: TextStyle(
                    color: Color(0xFF0C7230),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Footer text
              Text(
                '© 2024 Helen. All Rights Reserved',
                style: TextStyle(
                  color: Color(0xFF0C7230),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
