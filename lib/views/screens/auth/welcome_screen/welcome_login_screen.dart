import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_app/vendor/views/auth/vendor_login_screen.dart';
import 'package:uber_app/vendor/views/auth/vendor_register.dart';
import 'package:uber_app/views/screens/auth/login_screen.dart';
import 'package:uber_app/views/screens/auth/welcome_screen/welcome_register_screen.dart';

class WelcomeLoginScreen extends StatelessWidget {
  const WelcomeLoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.yellow.shade900,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -40,
              top: 0,
              child: Image.asset(
                'assets/images/doorpng2.png',
                width: screenWidth + 80,
                height: screenHeight + 100,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: screenWidth * 0.024,
              top: screenHeight * 0.151,
              child: Image.asset(
                'assets/images/Illustration.png',
                width: screenWidth * 0.92,
                height: screenHeight * 0.523,
                fit: BoxFit.cover,
              ),
            ),
            // Positioned(
            //   left: screenWidth * 0.178,
            //   top: screenHeight * 0.065,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(7),
            //     clipBehavior: Clip.hardEdge,
            //     child: Image.asset(
            //       'assets/images/one-famili-2-2.png',
            //       width: screenWidth * 0.65,
            //       height: screenHeight * 0.197,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Positioned(
              left: screenWidth * 0.07,
              top: screenHeight * 0.641,
              child: InkWell(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.085,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    // Center the text vertically and horizontally
                    child: Text(
                      'Login As Buyer',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.black,
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.07,
              top: screenHeight * 0.77,
              child: InkWell(
                onTap: () {
                  Get.to(() => VendorLoginScreen());
                },
                child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.085,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    // Center the text vertically and horizontally
                    child: Text(
                      'Login As Seller',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.black,
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.065,
              top: screenHeight * 0.88,
              child: SizedBox(
                width: screenWidth * 0.72,
                height: screenHeight * 0.033,
                child: InkWell(
                  onTap: () {
                    Get.to(() => WelcomeRegisterScren());
                  },
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        const TextSpan(text: 'Don’t have an account?'),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
