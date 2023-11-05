import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MedPieChart extends StatelessWidget {
  const MedPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return  PieChart(
      PieChartData(
        sections:[
          PieChartSectionData(
            value: 25,
            color: Colors.blue[300],
            
          )
        ]
      )
    );
  }
}