import 'package:flutter/material.dart';
import 'package:ras_project/Pages/location_tracker.dart';

class ConfirmeRequestPage extends StatelessWidget {
  const ConfirmeRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 84, 51, 1),  // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Your Robot is on the Way!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30.0, // Font size for text
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 225, 225, 225), // Text color
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60), // Add space between text and icon
            const Icon(
                Icons.check_circle_rounded, // Check icon
                color: Color.fromARGB(255, 255, 255, 255), // Icon color
                size: 160, // Icon size
              ),
            const SizedBox(height: 200),
            GestureDetector(
              onTap: () {
                // Action to perform when "Continue" is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackBus()),
                );
              },
              child: const Text(
              "Continue",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20, // Font size for text
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255), // Text color
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


