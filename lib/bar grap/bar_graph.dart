import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/bar%20grap/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunDosage;
  final double monDosage;
  final double tueDosage;
  final double wedDosage;
  final double thurDosage;
  final double friDosage;
  final double satDosage;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monDosage,
    required this.tueDosage,
    required this.wedDosage,
    required this.thurDosage,
    required this.friDosage,
    required this.satDosage,
    required this.sunDosage,
  });

  @override
  Widget build(BuildContext context) {
    //initializee the bar data
    BarData myBardata = BarData(
        monDosage: monDosage,
        tueDosage: tueDosage,
        wedDosage: wedDosage,
        thuDosage: thurDosage,
        friDosage: friDosage,
        satDosage: satDosage,
        sunDosage: sunDosage);
    myBardata.initializeBarData();
    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      barGroups: myBardata.barData
          .map((data) => BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(toY: data.y),
            ]
          ),)
          .toList(),
    ));
  }
}
