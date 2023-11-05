// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IntroScreenThree extends StatelessWidget {
  const IntroScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Stay Updated!",
              style: TextStyle(
                color: Colors.green[300],
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),
            ),
            Image.asset(
              './assets/images/doc.png',
              height: 240.0,
            ),
            Text(
              "Help you Keep track of your Medication",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              "A better way to Keep your medication in check.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
