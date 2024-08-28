// ignore_for_file: library_private_types_in_public_api, dead_code

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:helen_app/src/views/screens/farmers/registration_module/take_picture.dart';
import 'dart:io';

class ServicesMode extends StatefulWidget {

  final Map<String, String> registrationData; 

  const ServicesMode({super.key, required this.registrationData});

  @override
  _ServicesModeState createState() => _ServicesModeState();
  
}

class _ServicesModeState extends State<ServicesMode> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _farmLocationController = TextEditingController();
  final TextEditingController _designatedPickUpController = TextEditingController();
  final TextEditingController _specifiedAreaController = TextEditingController();
  final TextEditingController _otherModeOfDeliveryController = TextEditingController();

  File? gcashQrFile;
  File? bankTransferQrFile;

  // State variables for the additional options under "Preferred Delivery"
  bool isGcashChecked = false;
  bool isBankTransferChecked = false;
  bool isDeliveryToBuyerChecked = false;
  bool isSpecificAreaChecked = false;
  bool isPickUpChecked = false;
  bool isOtherModeChecked = false;
  bool isCashChecked = false;
  bool isAnyAreaChecked = false;

  // New state variables for the additional options under "Preferredweqtfew Pick Up"
  bool isPickUpAtFarmChecked = false;
  bool isDesignatedPickUpAreaChecked = false;

  @override
  void initState() {
    super.initState();
    // Initialize any other state here
  }

  // File picker variables
  String? gcashQrFileName;
  String? bankTransferQrFileName;

  // Function to handle file picking
 Future<void> _pickFile({required bool isGcash}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isGcash) {
          gcashQrFile = File(result.files.single.path!);
        } else {
          bankTransferQrFile = File(result.files.single.path!);
        }
      });
    }
 }

  bool get isDeliveryModeSelected {
    return isPickUpChecked || isDeliveryToBuyerChecked || isOtherModeChecked;
  }

  bool get isPaymentModeSelected {
    return isCashChecked || isGcashChecked || isBankTransferChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mode of Services',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFCA771A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
              controller: _farmLocationController,
              decoration: InputDecoration(
                labelText: 'Farm Location',
                hintText: 'Enter your farm location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                ),
                labelStyle: const TextStyle(fontFamily: 'Poppins'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your farm location';
                }
                return null;
              },
            ),

              const SizedBox(height: 30),

              // Mode of Delivery Section
              const Center(
                child: Text(
                  'Mode of Delivery:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hi, Farmer! What delivery options do you offer? Please review and confirm the available methods",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Pickup Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCA771A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'Preferred Pick Up',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isPickUpChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isPickUpChecked = value ?? false;
                        });
                      },
                    ),
                    if (isPickUpChecked) ...[
                      CheckboxListTile(
                        title: const Text(
                          'Pick up at your farm',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                        value: isPickUpAtFarmChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isPickUpAtFarmChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text(
                          'Designated pick-up area',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                        value: isDesignatedPickUpAreaChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isDesignatedPickUpAreaChecked = value ?? false;
                          });
                        },
                      ),
                      if (isDesignatedPickUpAreaChecked)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _designatedPickUpController,
                            decoration: InputDecoration(
                              labelText: 'Please specify pick-up location',
                              hintText: 'Enter pick-up location',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                              ),
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                            ),
                            validator: (value) {
                              if (isDesignatedPickUpAreaChecked && (value == null || value.isEmpty)) {
                                return 'Please specify pick-up location';
                              }
                              return null;
                            },
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Delivery to Buyer Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCA771A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'Deliver to Buyer',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isDeliveryToBuyerChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isDeliveryToBuyerChecked = value ?? false;
                        });
                      },
                    ),
                    if (isDeliveryToBuyerChecked) ...[
                      CheckboxListTile(
                        title: const Text(
                          'At any area/location identified by the buyer',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                        value: isAnyAreaChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isAnyAreaChecked = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text(
                          'Within specific area/location only',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                        value: isSpecificAreaChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isSpecificAreaChecked = value ?? false;
                          });
                        },
                      ),
                      if (isSpecificAreaChecked)
                        TextFormField(
                          controller: _specifiedAreaController,
                          decoration: InputDecoration(
                            labelText: 'Please specify up to what area',
                            hintText: 'Enter the specific area',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                            ),
                            labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          validator: (value) {
                            if (isSpecificAreaChecked && (value == null || value.isEmpty)) {
                              return 'Please specify up to what area';
                            }
                            return null;
                          },
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Other Mode Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCA771A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'Other Mode',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isOtherModeChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isOtherModeChecked = value ?? false;
                        });
                      },
                    ),
                    if (isOtherModeChecked)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _otherModeOfDeliveryController,
                          decoration: InputDecoration(
                            labelText: 'Please specify',
                            hintText: 'Enter the other mode of delivery',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Color(0xFFCA771A), width: 2.0),
                            ),
                            labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          validator: (value) {
                            if (isOtherModeChecked && (value == null || value.isEmpty)) {
                              return 'Please specify the other mode of delivery';
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Mode of Payment Section
              const Center(
                child: Text(
                  'Mode of Payment:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFCA771A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hi, Farmer! What payment options do you offer? Please review and confirm the available methods",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

             // Cash Payment Section
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCA771A)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CheckboxListTile(
                title: const Text(
                  'Cash on Delivery',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                ),
                value: isCashChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isCashChecked = value ?? false;
                  });
                },
              ),
            ),
              const SizedBox(height: 20),

              // GCash Payment Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCA771A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'GCash',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isGcashChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isGcashChecked = value ?? false;
                        });
                      },
                    ),
                    if (isGcashChecked)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.upload),
                            onPressed: () => _pickFile(isGcash: true),
                          ),
                          Expanded(
                            child: Text(
                              style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                              gcashQrFileName ?? 'Upload GCash QR Code',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bank Transfer Payment Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCA771A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'Bank Transfer',
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      ),
                      value: isBankTransferChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isBankTransferChecked = value ?? false;
                        });
                      },
                    ),
                    if (isBankTransferChecked)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.upload),
                            onPressed: () => _pickFile(isGcash: false),
                          ),
                          Expanded(
                            child: Text(
                              style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                              bankTransferQrFileName ?? 'Upload Bank Transfer QR Code',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
             Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (!isPaymentModeSelected || !isDeliveryModeSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least one mode of delivery and one mode of payment.'),
                          ),
                        );
                        return;
                      }

                      List<String> modeOfDelivery = [''];
                      List<String> modeOfPayment = [''];

                      // Check if the `isPickUpChecked` is true
                    if (isPickUpChecked) {
                      if (isPickUpAtFarmChecked) {
                        modeOfDelivery.add("Pick-up at my farm location: ${_farmLocationController.text}");
                      }

                      if (isDesignatedPickUpAreaChecked) {
                        modeOfDelivery.add("Pick-up at: ${_designatedPickUpController.text}");
                      }
                    }

                    if (isDeliveryModeSelected) {
                      if (isAnyAreaChecked) {
                        modeOfDelivery.add("Delivery at any area the buyer requested");
                      }

                      if (isSpecificAreaChecked) {
                        modeOfDelivery.add("Delivery within the given specified area: ${_specifiedAreaController.text}");
                      }
                    }

                    if (isOtherModeChecked) {
                      modeOfDelivery.add("Other mode of Service: ${_otherModeOfDeliveryController.text}");
                    }

                    if (isCashChecked) {
                      modeOfPayment.add("Cash");
                    }



                     final Map<String, dynamic> modeOfServiceData = {
                        'farmLocation': _farmLocationController.text,
                        'modeOfDelivery': modeOfDelivery,  // List of delivery modes
                        'modeOfPayment': modeOfPayment,    // List of payment modes''

                      };
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CapturePictureScreen(
                            registrationData: widget.registrationData,
                            modeOfServiceData: modeOfServiceData,
                            gcashQrFile: gcashQrFile, // Pass the file or null
                            bankTransferQrFile: bankTransferQrFile, // Pass the file or null
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA771A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}