// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously, unnecessary_null_comparison, prefer_const_declarations, avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helen_app/src/views/common/login.dart';
import 'dart:io';
import 'dart:math'; // For generating OTP
import 'package:helen_app/src/services/api_service.dart';


class OtpPage extends StatefulWidget {
  final Map<String, String> registrationData;
  final Map<String, dynamic> modeOfServiceData;
  final File? imageFile;
  final File? businessPermitFile;
  final File? gcashQrFile;
  final File? bankTransferQrFile;
  final String type;

  const OtpPage({
    super.key,
    required this.registrationData,
    required this.modeOfServiceData,
    required this.type,
    this.imageFile,
    this.businessPermitFile,
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

  
  void _sendOtp() {
      final phoneNumber = widget.registrationData['contactNo'];
      print('phoneNumber: $phoneNumber');
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        sendOtp(phoneNumber);
      } else {
        print('Phone number is not provided.');
      }
  }

    // Generate a random OTP
  String generateOtp({int length = 6}) {
    final random = Random();
    final otp = List.generate(length, (_) => random.nextInt(10)).join();
    return otp;
  }

  

Future<void> sendOtp(String? phoneNumber) async {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    print('Invalid phone number');
    return;
  }

  final otp = generateOtp(); // Generate the OTP
  final message = "Your OTP code for Helen is %code%"; // Use %code% as a placeholder for the OTP

  // Save OTP for later verification (you might want to store this in a backend or in a secure place)
  _verificationId = otp;

  final response = await http.post(
    Uri.parse('https://api.semaphore.co/api/v4/otp'),  // Use Semaphore's OTP endpoint
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'apikey': 'b95d4ce6dca75dcd54cea894194715f1',  // Your actual API key
      'number': phoneNumber,  // Recipient's phone number
      'message': message,  // The message with %code% placeholder for OTP
      'sendername': 'Helen',  // Optional, your sender name registered with Semaphore
      'code': otp,  // The generated OTP code
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    // OTP sent successfully
    print('OTP has been sent successfully!');
    // You can display a Snackbar or toast to notify the user
  } else {
    print('Failed to send OTP: ${response.body}');
  }
}

 bool verifyOtp(String enteredOtp) {
    if (_verificationId == null) {
      print('No OTP to verify');
      return false;
    }
    if (enteredOtp == _verificationId) {
      print('OTP verification successful!');
      return true;
    } else {
      print('OTP verification failed!');
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  bool isSuccess = false;
                 
                 print('otp: $otp');
                  bool isVerified = await verifyOtp(otp);  
     
                  if (isVerified && mounted ) {
                  // Show a success dialog or SnackBar

                    if(widget.type == "farmer"){
                      final sendServiceResult = await sendModeOfServiceData(
                        modeOfServiceData: widget.modeOfServiceData,
                        gcashQrFile: widget.gcashQrFile,
                        bankTransferQrFile: widget.bankTransferQrFile,
                      );
                    
                      print('result $sendServiceResult');
                        // Check if sendServiceResult is not null and was successful
                      if (sendServiceResult != null) {

                        

                        isSuccess = await registerFarmer( 
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
                      
                      }
                    }

                    if(widget.type == "buyer"){
                     
     

                        isSuccess = await registerBuyer( 
                          username: widget.registrationData['username'] ?? '',
                          fullName: widget.registrationData['fullName'] ?? '',
                          address: widget.registrationData['address'] ?? '',      
                          contactNo: widget.registrationData['contactNo'] ?? '',  
                          password: widget.registrationData['password'] ?? '',
                          accountType: widget.registrationData['accountType'] ?? '',
                          businessPermit: widget.businessPermitFile     
                          
                        );
  
                    }
                    
                    
                    if (isSuccess) {
                            // Handle success, e.g., navigate to another screen
                      print('User registered successfully.');
                        
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
                    print('Failed to verify');
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