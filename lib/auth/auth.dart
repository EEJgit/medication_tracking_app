// ignore_for_file: prefer_const_constructors
//this page checks if the user is logged in or not.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/auth/login_or_register.dart';
import 'package:medication_tracking_app/pages/home_page.dart';

//This is the authentication page
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //inside this body we are going to have the stream builder that will listeb for
      //firebase authentication.
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginOrRegistration();
            }
          }),
    );
  }
}
