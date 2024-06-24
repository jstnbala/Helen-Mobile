import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: GreenClipper(),
            child: Container(
              color: Color(0xFF0C7230),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(
                  child: Image.asset(
                    'images/farmers/white-helen.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Harnessing Expanded, Livelihood Enterprise and Network',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Gabay sa Pamimili, Kaagapay sa Pagsasaka, Kakampi sa Pag-unlad.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/account-type'); // Navigate to account type page
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF0C7230),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 80,
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75); 
    path.quadraticBezierTo(0, size.height, size.width * 0.25, size.height);  
    path.lineTo(size.width * 0.75, size.height); 
    path.quadraticBezierTo(size.width, size.height, size.width, size.height * 0.75); 
    path.lineTo(size.width, 0); 
    path.lineTo(0, 0); 
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
