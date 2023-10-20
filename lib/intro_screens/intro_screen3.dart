// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IntroScreenThree extends StatelessWidget {
  const IntroScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 52, 69, 165),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Stay Updated!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
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
