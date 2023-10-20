import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/components/button.dart';
import 'package:medication_tracking_app/components/text_filed.dart';

//this is The login page
class RegistrationPage extends StatefulWidget {
  final Function()? onTap;
  const RegistrationPage({super.key, required this.onTap});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    //These are the texfield controller objects
    //The email controller
    TextEditingController emailController = TextEditingController();
    //password controller
    TextEditingController passwordController = TextEditingController();
    //Password confirmation
    TextEditingController comfirmPassword = TextEditingController();
    //username first name controller
    TextEditingController firstNameController = TextEditingController();
    //username Last name controller
    TextEditingController lastNameController = TextEditingController();
    //Age controller
    TextEditingController ageController = TextEditingController();
    //usesr phone number
    //TextEditingController phoneController = TextEditingController();

    //the display message method.
    void displayMessage(String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
                message)), //displays the state message of the password or email validity.
      );
    }

    //++++++++==============The AddUserdatils method starts here
    //sign up method ends here

    //add user details methods
   /* Future addUserDetails(
        String firstName, String LastName, String email, int age) async {
      await FirebaseFirestore.instance.collection('users').add({
        'first name': firstName,
        'last Name': LastName,
        'email address': email,
        'age': age,
      });
    }
    */
    Future<void> addUserDetails(
        String firstName, String lastName, String email, int age) async {
      // Create a document reference with a specific document ID (e.g., user's email)
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(email);

      // Set data in the document using the reference
      await docRef.set({
        'first name': firstName,
        'last name': lastName,
        'email address': email,
        'age': age,
      });
    }

    //+++++++++++++++++++++=================The signUp method
    void signUp() async {
      //show the the loading circular loading
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      //comfirm if the passwords match or not
      if (passwordController.text != comfirmPassword.text) {
        //pop the loading circle
        Navigator.pop(context);
        //show the error message for the unconfirmed passwords
        displayMessage("Your passwords dont match!");
        return;
      }

      ///we make a try and catch for the password confirmation
      ///
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //once the user is created you need to pop the context navigator loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //so if theres an error we catch it below
        // ignore: use_build_context_synchronously
        Navigator.pop(
            context); //we pop the loading circle to display the error dialog from firebase
        //we display the error to the use
        displayMessage(e.code);
      }
      //add user details on sign up
      addUserDetails(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          emailController.text.trim(),
          int.parse(ageController.text.trim()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Login Icon here on top
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.grey[800],
                    size: 40,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //The welccome message for the For the sign up page
                  Text(
                    "Lets create an Account for you",
                    //Styles for the Welcome text.
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  //first name controller
                  const SizedBox(
                    height: 10,
                  ),
                  //User first Name textField in put here to firebase
                  UserTextField(
                    controller: firstNameController,
                    hintText: 'Please Enter your First Name',
                    obsecuretext: false,
                  ),
                  //last Name Controller
                  const SizedBox(
                    height: 10,
                  ),
                  UserTextField(
                    controller: lastNameController,
                    hintText: 'Please Enter your Last Name',
                    obsecuretext: false,
                  ),
                  //Phone number
                  const SizedBox(height: 10),
                  UserTextField(
                    controller: ageController,
                    hintText: 'Please Enter your Age',
                    obsecuretext: false,
                  ),
                  //user email text field after the SizedBox widget
                  const SizedBox(
                    height: 10,
                  ),
                  //User email textField in put here to firebase
                  UserTextField(
                    controller: emailController,
                    hintText: 'Please Enter your Email',
                    obsecuretext: false,
                  ),

                  //User's password to firebase
                  const SizedBox(
                    height: 10,
                  ),
                  //User email textField in put here to firebase
                  UserTextField(
                    controller: passwordController,
                    hintText: 'Please Enter your Password',
                    obsecuretext: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //User's password to firebase
                  //User email textField in put here to firebase
                  UserTextField(
                    controller: comfirmPassword,
                    hintText: 'Please Comfirm your Password',
                    obsecuretext: true,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  //User onTap button to submit the user details form
                  UserButton(
                    onTap: signUp, //The sign up method to submit the form
                    text: "Sign Up",
                  ),
                  //Switch to the register here page if no account was found.
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        //onTap method to switch between sigin and signup screens
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign In.",
                          style: TextStyle(
                            color: Colors.blue,
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
