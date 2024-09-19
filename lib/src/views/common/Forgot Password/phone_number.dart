// ignore_for_file:,, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:helen_app/src/views/common/Forgot%20Password/otp-page-forgot-pass.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:helen_app/src/services/forgot_password_api.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController controller = TextEditingController();
  final PhoneNumber initialNumber = PhoneNumber(isoCode: 'PH'); // Default to PH format

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
                        'Phone Number',
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

            // Forgot Password Icon
            const Icon(
              Icons.person_outline,
              size: 100,
              color: Color(0xFFCA771A),
            ),
            const SizedBox(height: 20),

            // Info Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Please type your registered phone number for you to continue changing your previously used password. \n \n We will send an OTP Verification to you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Contact Number Field with PH format
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  // Handle phone number input change if necessary
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                  setSelectorButtonAsPrefixIcon: true,
                  leadingPadding: 10.0,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                initialValue: initialNumber,
                textFieldController: controller,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                inputDecoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'e.g: 908 345 5341',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFCA771A), width: 2.0),
                  ),
                ),
                onInputValidated: (bool value) {
                  // Handle validation
                },
                onSaved: (PhoneNumber number) {
                  // Handle phone number save if necessary
                },
              ),
            ),
            const SizedBox(height: 30),

            // Change Password Button
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
                // Remove spaces from the phone number
                final phoneNumberString = '+63${controller.text.replaceAll(' ', '')}';
                final UpdatePasswordApi updatePasswordApi = UpdatePasswordApi();

                // Call getAccount method to verify the phone number
                final data = await updatePasswordApi.getAccount(phoneNumberString);

                if (data != null) {
                  // If the account exists, navigate to the OTP page
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpPage(
                        phoneNumber: phoneNumberString,
                        userId: data['id'],
                        type: data['type'],
                      ),
                    ),
                  );
                } else {
                  // Show an error message if the account is not found
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Phone number not found in the system')),
                  );
                }
              },

                child: const Center(
                  child: Text(
                    'Send me the code',
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
}