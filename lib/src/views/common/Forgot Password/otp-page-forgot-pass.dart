// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:helen_app/src/views/common/Forgot%20Password/create_new_password.dart';

import 'dart:io';

import 'package:helen_app/src/services/api_service.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String userId;
  final String type;

  const OtpPage({
    super.key,
    required this.phoneNumber,
    required this.userId,
    required this.type
  });

 
  @override
  _OtpPageState createState() => _OtpPageState();
}
 

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    // Automatically send OTP when the page is loaded
    _sendOtp();
     _setupOtpListeners();
  }

    void _setupOtpListeners() {
    _otpController1.addListener(() {
      if (_otpController1.text.length == 1) {
        FocusScope.of(context).requestFocus(_focusNode2);
      }
    });
    _otpController2.addListener(() {
      if (_otpController2.text.length == 1) {
        FocusScope.of(context).requestFocus(_focusNode3);
      } else if (_otpController2.text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNode1);
      }
    });
    _otpController3.addListener(() {
      if (_otpController3.text.length == 1) {
        FocusScope.of(context).requestFocus(_focusNode4);
      } else if (_otpController3.text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNode2);
      }
    });
    _otpController4.addListener(() {
      if (_otpController4.text.length == 1) {
        FocusScope.of(context).requestFocus(_focusNode5);
      } else if (_otpController4.text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNode3);
      }
    });
    _otpController5.addListener(() {
      if (_otpController5.text.length == 1) {
        FocusScope.of(context).requestFocus(_focusNode6);
      } else if (_otpController5.text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNode4);
      }
    });
    _otpController6.addListener(() {
      if (_otpController6.text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNode5);
      }
    });
  }

    @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }
  
  void _sendOtp() {
      final phoneNumber ='+1 234-567-8999';
      
      if (phoneNumber.isNotEmpty) {
        sendOtp(phoneNumber);
      } else {
        print('Phone number is not provided.');
      }
  }

  String _obfuscatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.length < 7) {
      // Handle cases where the phone number is too short or null to obfuscate
      return phoneNumber ?? '';
    }
    String firstPart = phoneNumber.substring(0, 3); // First 3 digits
    String lastPart = phoneNumber.substring(phoneNumber.length - 4); // Last 4 digits
    String middlePart = '*' * (phoneNumber.length - 7); // Replace middle part with asterisks
    return '$firstPart$middlePart$lastPart';
  }

  Future<void> sendOtp(String? phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;


    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification succeeded
        await auth.signInWithCredential(credential);
        // Navigate to next page if needed
      },
      
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print('Something went wrong: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verificationId for later when verifying OTP
        setState(() {
          _verificationId = verificationId;
        });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP has been sent successfully!'),
              duration: Duration(seconds: 3),
            ),
          );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    
    try {
      await auth.signInWithCredential(credential);
      // Navigate to next page after successful verification
      return true;
    } catch (e) {
      // Handle error, e.g., invalid OTP
      print('Error verifying OTP: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFCA771A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder to balance the center text
                ],
              ),
            ),
            const SizedBox(height: 40),
 
            // OTP Icon
            const Icon(
                Icons.security,
                size: 100,
                color: Color(0xFFCA771A),
            ),
            const SizedBox(height: 20),
 
            // Info Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'We have sent the verification code through SMS. Please check your messages and enter the code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
 
            // Phone Number Placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                _obfuscatePhoneNumber(widget.phoneNumber), // Placeholder, will be updated later
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCA771A),
                ),
              ),

              
            ),
            const SizedBox(height: 20),
 
            // OTP Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center OTP fields
               children: [
                  _buildOtpField(_otpController1, _focusNode1),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController2, _focusNode2),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController3, _focusNode3),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController4, _focusNode4),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController5, _focusNode5),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController6, _focusNode6),
                ],
              ),
            ),
            const SizedBox(height: 20),
 
            // Resend Code Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                        sendOtp('+1 234-567-8999');
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Color(0xFFCA771A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
 
            // Verify Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA771A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () async {
                  String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text + _otpController5.text + _otpController6.text;
      
                 
                  print('otp: $otp');
                  bool isVerified = await verifyOtp(otp);  
     
                  if (isVerified && mounted ) {
              
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Verification Successful'),
                              content: const Text('Your OTP has been verified successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                        // Navigate to the next page after closing the dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ResetPasswordPage(userId: widget.userId, type: widget.type)),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      
                  }  else if (mounted) {
                          // Show an error message if OTP verification failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid OTP, please try again.')),
                      );
                    }
                },
                  
                child: const Center(
                  child: Text(
                    'Verify OTP',
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
            const SizedBox(height: 20), // Added bottom spacing
          ],
        ),
      ),
    );
  }
 
  // Widget for individual OTP fields
   Widget _buildOtpField(TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFCA771A), // Focused border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          counterText: '', // Hide character counter
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    );
  }
}