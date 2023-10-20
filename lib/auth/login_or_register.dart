///This is an authentication page that helps reroute the user
///if theyre are logged in to the homepage and if not then
///it will go to the registration page.
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/pages/login_page.dart';
import 'package:medication_tracking_app/pages/registration_page.dart';

class LoginOrRegistration extends StatefulWidget {
  const LoginOrRegistration({super.key});

  @override
  State<LoginOrRegistration> createState() => _LoginOrRegistrationState();
}

class _LoginOrRegistrationState extends State<LoginOrRegistration> {
  //initially show the login page
  bool showLoginPage = false;

  //using the setstate to toggle between the pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegistrationPage(onTap: togglePages);
    }
  }
}
