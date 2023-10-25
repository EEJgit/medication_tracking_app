import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key, });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3455A5), // Professional blue color
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Icon(
            Icons.local_hospital, // Replace with a relevant medical icon
            size: 80,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Text(
            "Medication Tracker",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Never miss a dose. Stay on top of your medication schedule.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
