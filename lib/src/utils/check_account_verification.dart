import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create an instance of FlutterSecureStorage
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

/// Utility function to check account verification status and show dialog if not verified
/// Accepts an optional `onVerified` callback function for actions to be taken if verified.
Future<void> checkAccountVerification(BuildContext context, {Function? onVerified}) async {
  try {
    // Retrieve account status from secure storage (assuming 'status' key is used to store this)
    String? accountStatus = await secureStorage.read(key: 'status');

    // If accountStatus is not "verified", show alert dialog
    if (accountStatus != 'Verified') {
      showVerificationRequiredDialog(context);
    } else {
      // If account is verified, proceed with the provided callback or default action
      if (onVerified != null) {
        onVerified();
      } else {
        // Default action if no callback is provided
        debugPrint("Account is verified, proceed with default action.");
      }
    }
  } catch (e) {
    // Handle potential errors (e.g., issues accessing secure storage)
    debugPrint("Error checking account verification: $e");
    // Optionally, show a different error dialog if needed
  }
}

/// Function to show an alert dialog informing the user they need to wait for admin verification
void showVerificationRequiredDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Verification Required'),
        content: const Text(
          'Your account is not verified yet. Please wait for an admin to verify your account in order to access these features.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
