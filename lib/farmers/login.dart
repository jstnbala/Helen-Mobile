import 'package:flutter/material.dart';
import 'package:helen_app/farmers/nav-bar.dart';
import 'package:helen_app/farmers/forgotpass.dart'; // Import ForgotPassPage class
import 'package:helen_app/farmers/registration-farmer.dart'; // Import FarmerRegistrationPage class

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Expected credentials
  String _expectedUsername = 'akosiNestor';
  String _expectedPassword = '@Farming31';

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
              // Background and header section
              Container(
                width: size.width,
                height: size.height * 0.4,
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
                          'images/farmers/login-bg.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.4,
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
                                height: 140,
                                child: Image.asset('images/farmers/white-helen.png'),
                              ),
                              SizedBox(width: 3),
                              SizedBox(
                                height: 140,
                                child: Image.asset('images/farmers/logo-opa.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome, Farmer!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please log in using your credentials below',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Username TextField
              Center(
                child: Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      labelStyle: TextStyle(color: Color(0xFF0C7230), fontFamily: 'Poppins'),
                      hintStyle: TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Password TextField
              Center(
                child: Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      labelStyle: TextStyle(color: Color(0xFF0C7230), fontFamily: 'Poppins'),
                      hintStyle: TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7230), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF0C7230),
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
              SizedBox(height: 8),
              // Forgot Password TextButton
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassPage()),
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
                          MaterialPageRoute(builder: (context) => Navbar()),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 15),
              // Register Text and Link
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FarmerRegistrationPage()),
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
