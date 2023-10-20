// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// this is the user button to toggle login or register
class UserButton extends StatelessWidget {
  final Function()? onTap; //the function to submit the form when tapped.
  final String text; //the text to be shown on the button
  const UserButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Color.fromARGB(255, 52, 69, 165),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
