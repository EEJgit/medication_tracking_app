// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medication_tracking_app/global_bloc.dart';
import 'package:medication_tracking_app/local%20notifications/local_notifications.dart';
import 'package:medication_tracking_app/models/medicine.dart';
import 'package:medication_tracking_app/pages/home_page.dart';
import 'package:provider/provider.dart';

class MedicationDetails extends StatefulWidget {
  const MedicationDetails(
    this.medicine, {
    super.key,
  });

  final Medicine medicine;

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
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

  openAlertBox(BuildContext context, GlobalBloc globalBloc) {
    // this is alert box for the deletion confirmation
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            title:  Text(
              "Delete this Reminder?",
              style: TextStyle(
                color: Colors.green[500]
              ),
            ),
            //the actions for the cancel and confirm deletion  button
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.green[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //this is the global bloc to delete the  medication.
                  globalBloc.removeMedication(widget.medicine);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                  //notification closer
                  LocalNotifications.closeAll();
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 18,
                  ),
                ),
              )
            ],
          );
        });
  }
//we delete a medicine from memory

  @override
  Widget build(BuildContext context) {
    //we delete medication from the
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          "$firstName's Medication Details",
          style: TextStyle(
            color: Colors.green[200],
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainSection(
              medicine: widget.medicine,
            ),
            //The extended tab for more information for the medication.
            ExtendedSection(
              medicine: widget.medicine,
            ),
            const Spacer(),
            //the delete button
            SizedBox(
              width: 400,
              height: 56,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      return Color.fromARGB(255, 32, 179, 51);
                    },
                  ),
                ),
                onPressed: () {
                  //open the alert dialog for the deletion notice. plus the global bloc to delete and manage the medication states.
                  openAlertBox(context, globalBloc);
                },
                child: const Text(
                  "D E L E T E",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

//Extended tab, which lays the medication info in a ListView
class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key, this.medicine});
  final Medicine? medicine;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 30,
        ),
        ExtendedTabInfo(
          fieldTitle: "Medicine Type",
          fieldInfo: medicine!.medicineType! == "None"
              ? "Not specified"
              : medicine!.medicineType!,
        ),
        ExtendedTabInfo(
            fieldTitle: "Dose Interval",
            fieldInfo:
                "Every ${medicine!.interval} | ${medicine!.interval == 24 ? 'One time a Day' : '${(24 / medicine!.interval!).floor()} times a day'}"),
        ExtendedTabInfo(
          fieldTitle: "Start Time",
          fieldInfo:
              "${medicine!.startTime![0]}${medicine!.startTime![1]}:${medicine!.startTime![2]}${medicine!.startTime![3]}",
        ),
      ],
    );
  }
}

//MainTab information for the medication
class MainSection extends StatelessWidget {
  const MainSection({super.key, this.medicine});
  //the medicine variables
  final Medicine? medicine;

  //The Hero Method
  Hero makeIcon() {
    if (medicine!.medicineType == 'Bottle') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(
          height: 70,
          'assets/icons/bottle.svg',
        ),
      );
    } else if (medicine!.medicineType == 'Pill') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(height: 70, 'assets/icons/pill.svg'),
      );
    } else if (medicine!.medicineType == 'Syringe') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(height: 70, 'assets/icons/syringe.svg'),
      );
    } else if (medicine!.medicineType == 'Tablet') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(
          height: 70,
          'assets/icons/tablet.svg',
        ),
      );
    }
    return Hero(
      tag: medicine!.medicineName! + medicine!.medicineType!,
      child: const Icon(
        Icons.error,
        size: 40,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeIcon(),
        Column(
          children: [
            //Medication Name details
            Hero(
              tag: medicine!.medicineName!,
              child: Material(
                color: Colors.transparent,
                child: MedicationInfoTab(
                  fieldInfo: medicine!.medicineName!,
                  fieldTitle: 'Medication Name',
                ),
              ),
            ),

            //This is the medication Dosage details
            MedicationInfoTab(
                fieldTitle: 'Dosage',
                fieldInfo: medicine!.dosage == 0
                    ? 'Not Specified'
                    : "${medicine!.dosage} mg"),
          ],
        ),
      ],
    );
  }
}

class MedicationInfoTab extends StatelessWidget {
  const MedicationInfoTab(
      {super.key, required this.fieldInfo, required this.fieldTitle});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 80,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Text(
              fieldTitle, //the name of the medication down here should be dynamic
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendedTabInfo extends StatelessWidget {
  const ExtendedTabInfo(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ),
          Text(
            fieldInfo,
            style:  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.green[400],),
          ),
        ],
      ),
    );
  }
}
