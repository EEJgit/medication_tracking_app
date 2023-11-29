// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/pages/home_page.dart';
import 'package:medication_tracking_app/side_bar/contact_information.dart';

class NextOfKin extends StatefulWidget {
  const NextOfKin({super.key});

  @override
  State<NextOfKin> createState() => _NextOfKinState();
}

class _NextOfKinState extends State<NextOfKin> {
  //this is the current user things
  //firebase name collector and other variables
  String firstName = "";
  String lastName = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.email).get();
      if (doc.exists) {
        setState(() {
          firstName = doc.get('first name');
          lastName = doc.get('last name');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

//%%%%%%%%%%%%%%%%%%%%%%FIREBASE CONNECTION AND EMERGENCY ADDITION%%%%%%
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final relationshipController = TextEditingController();
  final sexController = TextEditingController();

  //SAVE EMERGENCY CONTACT METHOD
  void saveEmergencyContact() async {
    final user = _auth.currentUser;
    if (user != null) {
      final contactData = {
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'location': locationController.text,
        'relationship': relationshipController.text,
        'sex': sexController.text,
      };

      await _firestore
          .collection('users')
          .doc(user.email)
          .collection('emergency')
          .add(contactData);

      // Clear the controllers after saving
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      locationController.clear();
      relationshipController.clear();
      sexController.clear();
    }
  }

//%%%%%%%%%%%%%%%%%%%ENDS HERE %%%%%%%%
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(
            "EMERGENCY CONTACTS",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                //Input Hour
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "$firstName's Emergency Contacts",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                //%%%%%%%%%%THE INPUT FOR THE MEDICATION NEXT OF KIN CONTACT
                // Input Fields for Emergency Contact
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Full Name",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Phone Number",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Email",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Location",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: relationshipController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Relationship",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: sexController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.grey[100],
                        hintText: "Sex",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ]),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveEmergencyContact();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              COntactInformation(), // Create an instance of the ContactInformation page
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green[700], // Text color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 100.0, right: 100.0, top: 20, bottom: 20),
                    child: Text(
                      'Save Contact',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
