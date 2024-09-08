// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

import 'package:helen_app/src/services/api_service.dart';
import 'package:helen_app/src/views/common/Forgot Password/phone_number.dart';
import 'package:helen_app/src/views/common/navbar.dart'; 
import 'package:helen_app/src/views/common/getstarted.dart'; // Import FarmerRegistrationPage class
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helen_app/src/context/socket_context.dart'; // Import your SocketContext
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool _obscurePassword = true;
  bool _isLoading = false; // Loading state
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final socketProvider = useSocketProvider(context);

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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
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
                        color: const Color(0xFFCA771A).withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
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
                              const SizedBox(width: 3),
                              SizedBox(
                                height: 140,
                                child: Image.asset('images/farmers/logo-opa.png'),
                              ), 
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Welcome, Ka-HELEN!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
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
              const SizedBox(height: 20),
              // Username TextField
              Center(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      labelStyle: const TextStyle(color: Color(0xFFCA771A), fontFamily: 'Poppins'),
                      hintStyle: const TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              Center(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      labelStyle: const TextStyle(color: Color(0xFFCA771A), fontFamily: 'Poppins'),
                      hintStyle: const TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFFCA771A),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                    obscureText: _obscurePassword,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Forgot Password TextButton
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {

                 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassPage()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login Button
              Center(
                child: SizedBox(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                           
                            final success = await login(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            );

                            setState(() {
                              _isLoading = false;
                            });

                            if (success) {
                              // Get user ID from the response or context (e.g., from storage or API)
                              String userId = await storage.read(key: 'id') ?? '';

                              // On successful login, connect the socket with the userId
                              socketProvider.connectSocket(userId);
                               Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const NavBar())
                               );
                            } else {
                              // Show error if credentials do not match
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Failed'),
                                  content: const Text('Invalid username or password. Please try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Color(0xFFCA771A)),
                      ),
                    ),
                    child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Color(0xFFCA771A),
                      )
                    : const Text(
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
              const SizedBox(height: 15),
              // Register Text and Link
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Color(0xFFCA771A),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetStartedPage()),
                  );
                },
                child: const Text(
                  'Register here',
                  style: TextStyle(
                    color: Color(0xFFCA771A),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Footer text
              const Text(
                '© 2024 Helen. All Rights Reserved',
                style: TextStyle(
                  color: Color(0xFFCA771A),
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
