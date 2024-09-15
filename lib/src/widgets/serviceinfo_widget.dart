// ignore_for_file: avoid_print

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
        print('Loaded serviceInfo: $serviceInfo'); // Debugging line
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return serviceInfo == null
        ? const Center(child: CircularProgressIndicator())
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
                if (serviceInfo != null && serviceInfo!['farmLocation'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Farm Location:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              serviceInfo!['farmLocation'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 15.0),
                if (serviceInfo != null && serviceInfo!['modeOfDelivery'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mode of Delivery:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_shipping,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: serviceInfo!['modeOfDelivery']
                                  .map<Widget>((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    '$item',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 15.0),
                if (serviceInfo != null && serviceInfo!['modeOfPayment'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mode of Payment:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      ...serviceInfo!['modeOfPayment'].map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8.0),
                              Flexible(
                                child: Text(
                                  '$item',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                const SizedBox(height: 15.0),
                if (serviceInfo != null && serviceInfo!['gcashQrFile'] != null)
                  Text(
                    'GCash QR File: ${serviceInfo!['gcashQrFile']}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                if (serviceInfo != null && serviceInfo!['bankTransferQrFile'] != null)
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
