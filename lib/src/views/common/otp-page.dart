// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'dart:io';

import 'package:helen_app/src/services/api_service.dart';

class OtpPage extends StatefulWidget {
  final Map<String, String> registrationData;
  final Map<String, dynamic> modeOfServiceData;
  final File imageFile;  // For image uploading
  final File? gcashQrFile;
  final File? bankTransferQrFile;


  const OtpPage({
    super.key,
    required this.registrationData,
    required this.modeOfServiceData,
    required this.imageFile,
    this.gcashQrFile,
    this.bankTransferQrFile,
  
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

  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    // Automatically send OTP when the page is loaded
    _sendOtp();
  }
  
  void _sendOtp() {
      final phoneNumber = widget.registrationData['contactNo'];
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
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
                _obfuscatePhoneNumber(widget.registrationData['contactNo']), // Placeholder, will be updated later
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
                  _buildOtpField(_otpController1),
                  const SizedBox(width: 10), // Less space between boxes
                  _buildOtpField(_otpController2),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController3),
                  const SizedBox(width: 10),
                  _buildOtpField(_otpController4),
                   const SizedBox(width: 10),
                  _buildOtpField(_otpController5),
                   const SizedBox(width: 10),
                  _buildOtpField(_otpController6),
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
                        sendOtp(widget.registrationData['contactNo']);
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
     
                  if (isVerified && mounted) {
                  // Show a success dialog or SnackBar

                    final sendServiceResult = await sendModeOfServiceData(
                      modeOfServiceData: widget.modeOfServiceData,
                      gcashQrFile: widget.gcashQrFile,
                      bankTransferQrFile: widget.bankTransferQrFile,
                    );
                    
                    print('result $sendServiceResult');
                        // Check if sendServiceResult is not null and was successful
                    if (sendServiceResult != null) {

                      final isSuccess = await registerFarmer( 
                        username: widget.registrationData['username'] ?? '',
                        fullName: widget.registrationData['fullName'] ?? '',
                        address: widget.registrationData['address'] ?? '',
                        organization: widget.registrationData['organization'] ?? '',
                        contactNo: widget.registrationData['contactNo'] ?? '',
                        rsbsaNo: widget.registrationData['rsbsaNo'] ?? '',
                        password: widget.registrationData['password'] ?? '',
                        serviceInfo: sendServiceResult,
                        imageFile: widget.imageFile,

                      );

                      if (isSuccess) {
                            // Handle success, e.g., navigate to another screen
                        print('Farmer registered successfully.');
                        
                          if (mounted) {
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
                                          MaterialPageRoute(builder: (context) => const LoginPage()),
                                        );
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else if (mounted) {
                          // Show an error message if OTP verification failed
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid OTP, please try again.')),
                          );
                        }
                            // Navigate to another screen or show success message
                    } else {    
                      print('Failed to register farmer.');       
                    }
                  } else {
                          // Handle failure to send mode of service data
                    print('Failed to send mode of service data or response was null.');

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
  Widget _buildOtpField(TextEditingController controller) {
    return SizedBox(
      width: 50, // Reduced width for smaller boxes
      child: TextField(
        controller: controller,
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