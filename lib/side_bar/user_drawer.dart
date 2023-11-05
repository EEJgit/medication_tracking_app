// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/side_bar/interactions_tracking.dart';
import 'package:medication_tracking_app/side_bar/medication_interactions.dart';
import 'package:medication_tracking_app/side_bar/next_of_kin.dart';
import 'package:medication_tracking_app/side_bar/pharmacy_map.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  //UserName and other firebase data fetch
  //firebase name collector and other variables
  String firstName = "";
  String lastName = '';
  String email = '';
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
          email = doc.get('email address');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  //#########Firebase Auth ends here ###
  void moveToKinDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NextOfKin(),
      ),
    );
  }

  ///User Medicatiion Interactions
  void interactionsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  MedicationInteractionScreen(),
      ),
    );
  }

///User Medicatiion Interactions
  void interactionsTracking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InteractionsPage(),
      ),
    );
  }

  ///User Medicatiion Interactions
  void pharmacyMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PharmacyMap(),
      ),
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey[700],
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
              accountName: Text("$firstName $lastName", style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
              accountEmail: Text(email),
            ),
            GestureDetector(
              onTap: moveToKinDetails,
              child: Row(
                children: [
                  IconButton(
                    onPressed: moveToKinDetails,
                    icon: Icon(
                      Icons.watch,
                      color: Colors.green[400],
                      size: 30,
                    ),
                  ),
                  Text(
                    "Schedule Medication time",
                    style: TextStyle(
                      color: Colors.green[400],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
            
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: interactionsPage,
              child: Row(
                children: [
                  IconButton(
                    onPressed: interactionsPage,
                    icon: Icon(
                      Icons.newspaper,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Medication News",
                    style: TextStyle(
                      color: Colors.green[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
            ),
            GestureDetector(
              onTap: interactionsTracking,
              child: Row(
                children: [
                  IconButton(
                    onPressed: interactionsTracking,
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Interactions Search",
                    style: TextStyle(
                      color: Colors.green[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: pharmacyMap,
              child: Row(
                children: [
                  IconButton(
                    onPressed: pharmacyMap,
                    icon: Icon(
                      Icons.map,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Pharmacy Map",
                    style: TextStyle(
                      color: Colors.green[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
