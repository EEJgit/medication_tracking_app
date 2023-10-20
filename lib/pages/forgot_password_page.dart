import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/components/button.dart';
import 'package:medication_tracking_app/components/text_filed.dart';

//this is the page used to reset the password for a user.

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //The variables
  TextEditingController emailController = TextEditingController();
  //Dispose if the above controller when the user enters their emails
  @override
  void dispose() {
    //implements a dispose
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    

    //the password reset method to perform the password resetting
    Future<void> passwordReset() async {
      final email = emailController.text.trim();

      if (email.isEmpty) {
        // Show an error message to the user if the email is empty.
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Please enter your email."),
            );
          },
        );
        return;
      }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Display a success message to the user.
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset email sent to $email."),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        
        // Show an error message to the user.
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("An error occurred: ${e.message}"),
            );
          },
        );
      }
    }


    ///
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            //The image image.
            
            //The Message on top of the page
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Please enter your email and we will send you a reset link!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19),
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            //The Reset password input
            UserTextField(
              controller: emailController,
              hintText: "Enter your Email",
              obsecuretext: false,
            ),
            const SizedBox(
              height: 10,
            ),

            //The user's submit button
            UserButton(
              onTap: passwordReset,
              text: "Reset",
            ),
          ],
        ),
      ),
    );
  }
}
