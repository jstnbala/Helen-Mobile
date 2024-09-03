import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class ServiceInfoWidget extends StatefulWidget {
  const ServiceInfoWidget({super.key});

  @override
  _ServiceInfoWidgetState createState() => _ServiceInfoWidgetState();
}

class _ServiceInfoWidgetState extends State<ServiceInfoWidget> {
  Map<String, dynamic>? serviceInfo;

  @override
  void initState() {
    super.initState();
    _loadServiceInfo();
  }

  Future<void> _loadServiceInfo() async {
    final jsonString = await storage.read(key: 'serviceInfo');
    if (jsonString != null) {
      setState(() {
        serviceInfo = jsonDecode(jsonString);
      });
    }
  }

  @override
 Widget build(BuildContext context) {
    return serviceInfo == null
        ? const CircularProgressIndicator()
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFCA771A),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Service Information',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Farm Location: ${serviceInfo!['farmLocation']}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Mode of Delivery: ${serviceInfo!['modeOfDelivery'].join(', ')}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Mode of Payment: ${serviceInfo!['modeOfPayment'].join(', ')}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                if (serviceInfo!['gcashQrFile'] != null)
                  Text(
                    'GCash QR File: ${serviceInfo!['gcashQrFile']}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                if (serviceInfo!['bankTransferQrFile'] != null)
                  Text(
                    'Bank Transfer QR File: ${serviceInfo!['bankTransferQrFile']}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
  }
}