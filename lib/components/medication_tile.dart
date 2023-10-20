import 'package:flutter/material.dart';

class MedicationTile extends StatelessWidget {
  final String name;
  final String dosage;
  final DateTime dateTime;
  const MedicationTile({
    super.key,
    required this.dosage,
    required this.name,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(name) ,
      subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
      trailing:Text(dosage),

    );
  }
}
