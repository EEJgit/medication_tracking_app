import 'package:flutter/material.dart';
import 'package:medication_tracking_app/bar%20grap/bar_graph.dart';
import 'package:medication_tracking_app/data/medication_Data.dart';
import 'package:provider/provider.dart';

class MedicationSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const MedicationSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationData>(
        builder: (context, value, child) => const SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: 100,
                monDosage: 10,
                tueDosage: 20,
                wedDosage: 35,
                thurDosage: 5,
                friDosage: 98,
                satDosage: 65,
                sunDosage: 16,
              ),
            ));
  }
}
