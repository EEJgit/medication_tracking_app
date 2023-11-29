import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/components/button.dart';
import 'package:medication_tracking_app/components/text_filed.dart';
import 'package:medication_tracking_app/pages/forgot_password_page.dart';

///this is the login page for the user login and firebase authenticatiion.

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //This is the controller to get the email from the user input
  TextEditingController controllerEmail = TextEditingController();
  //This is the password controller to collect user password.
  TextEditingController passwordController = TextEditingController();
  //The signIn method to send sign in details to firebase
 /* void signIn() async {
    //we show the loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          //the colors of the CircularProgressIndicator
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
        ),
      ),
    );

    //incase of an error we can catch it and try to sign in
   try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: passwordController.text,
      );
      //if loged in we need to pop the dialog
       // Check if the widget is still mounted before trying to close the dialog
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      //display the dialog before we dispaly the message
      Navigator.pop(context);
      //display error message.
      displayMessage(e.code);
    }
  }
  */
  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: passwordController.text,
      );

      // Check if the widget is still mounted before trying to close the dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e) {
      // Check if the widget is still mounted before trying to close the dialog
      if (context.mounted) {
        Navigator.pop(context);
        displayMessage(e.code);
      }
    }
  }

/*
  //This is fix for the mount
  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // Handle the exception
      Navigator.pop(context);
      displayMessage(e.code);
      

    } 
  }
*/
  //show the dialog message to the user concerning the email and password validity.
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(
              message)), //displays the state message of the password or email validity.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Login Icon here on top
                  const SizedBox(
                    height: 85,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.green[300],
                    size: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //The welccome message for the login page
                  Text(
                    "Welcome Back, you have been Missed!",
                    //Styles for the Welcome text.
                    style: TextStyle(
                      color: Colors.green[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //User email textField in put here to firebase
                  UserTextField(
                    controller: controllerEmail,
                    hintText: 'Please Enter your Email',
                    obsecuretext: false,
                  ),

                  //User's password to firebase
                  const SizedBox(
                    height: 15,
                  ),
                  //User email textField in put here to firebase
                  UserTextField(
                    controller: passwordController,
                    hintText: 'Please Enter your Password',
                    obsecuretext: true,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Forgot password Text Widget
                      GestureDetector(
                        onTap: () {
                          //we use this line to switch to the forgot password page.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.green[300]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //User onTap button to submit the user details form
                  UserButton(
                    onTap: signIn,
                    text: "Sign In",
                  ),
                  //Switch to the register here page if no account was found.
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text(
                        "Not a member?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        // This on tap enables the user to navigate betweeen the sign in and sign up pages.
                        onTap: widget.onTap,
                        child:  Text(
                          "Register.",
                          style: TextStyle(
                            color: Colors.green[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
