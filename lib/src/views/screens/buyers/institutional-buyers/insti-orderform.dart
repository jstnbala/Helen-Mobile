import 'package:flutter/material.dart';

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedProduct;
  String? _selectedWeight;
  final TextEditingController _quantityController = TextEditingController();
  String? _selectedPaymentMethod;

  final List<String> _products = ['Carrots', 'Corn', 'Lemons', 'Tomatoes'];
  final List<String> _weights = ['Kg', 'Lbs'];
  final List<String> _paymentMethods = ['Cash', 'GCASH', 'Bank'];

  final Map<String, double> _productPricesKg = {
    'Carrots': 50.0,
    'Corn': 30.0,
    'Lemons': 40.0,
    'Tomatoes': 60.0,
  };

  final Map<String, double> _productPricesLbs = {
    'Carrots': 22.7,
    'Corn': 13.6,
    'Lemons': 18.1,
    'Tomatoes': 27.2,
  };

  double _calculateTotalPrice() {
    final productPrice = (_selectedWeight == 'Kg'
        ? _productPricesKg[_selectedProduct]
        : _productPricesLbs[_selectedProduct]) ?? 0.0;
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    return productPrice * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Form',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInputContainer(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Product',
                        labelStyle: const TextStyle(color: Color(0xFFCA771A)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color(0xFFCA771A)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                      value: _selectedProduct,
                      items: _products.map((product) {
                        return DropdownMenuItem<String>(
                          value: product,
                          child: Text(product),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProduct = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              labelStyle: const TextStyle(color: Color(0xFFCA771A)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Color(0xFFCA771A)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Color(0xFFCA771A)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a quantity';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Weight Unit',
                              labelStyle: const TextStyle(color: Color(0xFFCA771A)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Color(0xFFCA771A)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Color(0xFFCA771A)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                            ),
                            value: _selectedWeight,
                            items: _weights.map((weight) {
                              return DropdownMenuItem<String>(
                                value: weight,
                                child: Text(weight),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedWeight = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a weight unit';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Options',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _paymentMethods.map((method) {
                        final bool isSelected = _selectedPaymentMethod == method;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = method;
                              });
                              if (method == 'GCASH' || method == 'Bank') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,  // Set background color to white
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Please scan the QR Code',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFFCA771A),  // Set text color to CA771A
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Image.asset('images/buyers/QR.png'),  // Display the QR code
                                        ],
                                      ),
                                       actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: const BorderSide(color: Color(0xFFCA771A)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFFCA771A),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFCA771A),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Done',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFCA771A) : Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFCA771A),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  method,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : const Color(0xFFCA771A),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Pricing Breakdown:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCA771A),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Product Price:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₱${_productPricesKg[_selectedProduct] != null ? _productPricesKg[_selectedProduct]!.toStringAsFixed(2) : '0.00'}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                    ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${_quantityController.text} ${_selectedWeight ?? ''}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₱${_calculateTotalPrice().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFCA771A),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFCA771A)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFCA771A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          // Show success dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                               content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Order Successfully Requested!',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '$_selectedProduct (${_quantityController.text} $_selectedWeight) requested.',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Please wait for the confirmation of your order. Thank you!',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFCA771A),
                                      ),
                                    ),
                                  ],
                                ),

                         actions: [
                                Center(  // Center the button
                                  child: SizedBox(
                                    width: 150,  // Make the button wider
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();  // Navigate back to homepage
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFCA771A),  // Same color as Order Request button
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCA771A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Order Request',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildInputContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}