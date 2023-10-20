import 'package:flutter/material.dart';

class PatientOrCaregiver extends StatefulWidget {
  const PatientOrCaregiver({super.key});

  @override
  State<PatientOrCaregiver> createState() => _PatientOrCaregiverState();
}

class _PatientOrCaregiverState extends State<PatientOrCaregiver> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Patient"),
        Text("Caregiver")
      ],
    );
  }
}