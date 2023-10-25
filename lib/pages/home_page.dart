// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medication_tracking_app/global_bloc.dart';
import 'package:medication_tracking_app/models/medicine.dart';
import 'package:medication_tracking_app/pages/medication_details/medication_details.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_page.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //phone and  permissions
  Telephony telephony = Telephony.instance;

  Future<void> requestTelephonyPermissions() async {
    Telephony telephony = Telephony.instance;
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

    if (permissionsGranted!) {
      // You have the necessary permissions, you can perform telephony-related tasks here.
    } else {
      // The user denied the permissions. Handle it accordingly.
    }
  }

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
        floatingActionButton: InkResponse(
          onTap: () {
            // go to new entry page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewEntryPage(),
              ),
            );
          },
          child: SizedBox(
              width: 65,
              height: 65,
              child: Card(
                color: Color.fromARGB(255, 52, 69, 165),
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              )),
        ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Hello, ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "$firstName 👋",
                style: TextStyle(
                    color: Colors.red[600],
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
              child: Column(children: [
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
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 52, 69, 165)),
            ),
            Text(
              "Welcome To MedSense.",
              style: TextStyle(fontSize: 20, color: Colors.red[200]),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<Medicine>>(
              stream: globalBloc!.medicineList$,
              builder: (context, snapshot) {
                return Text(
                  !snapshot.hasData ? "0" : snapshot.data!.length.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),
            //Here there should be the grid containing the medication
            Flexible(child: BottomContainer()),
          ])),
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
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No Medications",
              style: TextStyle(fontSize: 30, color: Colors.red[400]),
            ),
          );
        } else {
          return GridView.builder(
            padding: EdgeInsets.only(top: 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MedicineCard(
                medicine: snapshot.data![index],
              );
            },
          );
        }
      },
    );
  }
}

//The medication card
class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});
  //This is the medication variables
  final Medicine medicine;

  //first we need tot get the medication type icon
  Hero makeIcon() {
    if (medicine.medicineType == 'Bottle') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 50,
        ),
      );
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset('assets/icons/pill.svg',height: 50,),
      );
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset('assets/icons/syringe.svg', height: 50,),
      );
    } else if (medicine.medicineType == 'Tablet') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/tablet.svg',
          height: 50,
        ),
      );
    }
    //incase of no Icon for this
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(
        Icons.error,
        size: 40,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.red,
      onTap: () {
        //go to the medication activity or screen.with an animation
        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => MedicationDetails()));
        */
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: MedicationDetails(medicine,)
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );      },
      child: Container(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 3.0,
          bottom: 3.0,
        ),
        margin: EdgeInsets.all(22),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            //call the Medication Type and Icon here
            makeIcon(),
            SizedBox(
              height: 5,
            ),
            //this is the section for the medication's name.
            //This is the Hero Tag
            Hero(
              tag: medicine.medicineName!,
              child: Text(
                medicine.medicineName!,
                style: TextStyle(
                    color: Color.fromARGB(255, 52, 69, 165),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade,
                    letterSpacing: 2.0),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            //This is the section for the time interval.
            Text(
              medicine.interval == 1
                  ? "Every ${medicine.interval}Hour"
                  : "Every ${medicine.interval} Hours",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            Spacer(),
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
