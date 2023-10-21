// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medication_tracking_app/constants.dart';
import 'package:medication_tracking_app/global_bloc.dart';
import 'package:medication_tracking_app/pages/medication_details/medication_details.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  GlobalBloc? globalBloc;

  @override
  void initState() {
    super.initState();
    globalBloc = GlobalBloc();
    fetchUserData();
  }

  void signOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            children: [
              Text("Hello, ",
              style: TextStyle(
                color: kScaffoldColor,
              ),
              ),
              Text(
                "$firstName 👋",
                style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: Icon(
                Icons.logout,
                color: Colors.pink,
                size: 30,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 23,
                ),
                Text(
                  "Live Healthy, ",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 52, 69, 165)),
                ),
                Text(
                  "Worry Less! ",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 52, 69, 165)),
                ),
                Text(
                  "Welcome To MedSense.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "0",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Here there shoulbe the grid containing the medication
                Flexible(child: BottomContainer()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewEntryPage(),
                        ),
                      );
                    },
                    backgroundColor: Color.fromARGB(255, 52, 69, 165),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
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

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    /*  return Center(
      child: Text(
        "No Medications",
        style: TextStyle(fontSize: 30, color: Colors.red[400]),
      ),
    );
    */
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return MedicineCard();
      },
    );
  }
}

//The medication card
class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.red,
      onTap: () {
        //go to the medication activity or screen.with an animation
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MedicationDetails()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
        margin: EdgeInsets.all(22),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(
              "assets/icons/bottle.svg",
              height: 80,
            ),
            Spacer(),
            //this is the section for the medication's name.
            //This is the Hero Tag
            Text(
              "Benlyne",
              style: TextStyle(
                  color: Color.fromARGB(255, 52, 69, 165),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
            SizedBox(
              height: 2,
            ),
            //This is the section for the time interval.
            Text(
              "Every 8 hours",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
          ],
        ),
      ),
    );
  }
}

/*Column(
      children: [
        Text(
          "No Medications",
          style: TextStyle(fontSize: 30, color: Colors.red[400]),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CareGiver(),
              ),
            );
          },
          child: Text("Caregiver"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CareGiver(),
              ),
            );
          },
          child: Text("Patient"),
        ),
        Expanded(
          child: PatientOrCaregiver(),
        ),
        // Text("This is the $lastName"),
      ],
    );
    */
