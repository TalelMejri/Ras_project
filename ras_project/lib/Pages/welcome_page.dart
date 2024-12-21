import 'package:flutter/material.dart';
import 'package:ras_project/Pages/location_tracker.dart';
import 'package:ras_project/Pages/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            const Text(
              "Welcome to our \nclean world!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 170),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Color.fromRGBO(57, 180, 78, 1),
                    Color.fromRGBO(78, 233, 104, 1)
                  ],
                ),
              ),
              width: 140,
              height: 140,
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF1D1D1D),
                size: 90,
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                // Action to perform when "Continue" is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0, // Font size for text
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 71, 212, 92), // Text color
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
