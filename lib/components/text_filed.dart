// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//this is the text field component for the sign in or sign up pages.
//this connects the app to firebase

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecuretext;
  const UserTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecuretext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: obsecuretext,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey[100],
          hintText: hintText,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
      ),
    );
  }
}
