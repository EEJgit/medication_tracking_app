import 'package:medication_tracking_app/bar%20grap/individual_bar.dart';

class BarData {
  final double monDosage;
  final double tueDosage;
  final double wedDosage;
  final double thuDosage;
  final double friDosage;
  final double satDosage;
  final double sunDosage;

  BarData({
    required this.monDosage,
    required this.tueDosage,
    required this.wedDosage,
    required this.thuDosage,
    required this.friDosage,
    required this.satDosage,
    required this.sunDosage,
  });

  //this is  alist of individual data called barData
  List<IndividualBar> barData = [];

  //initialize bardata
  void initializeBarData() {
    barData = [
      //sun
      IndividualBar(x: 0, y: sunDosage),
      //mon
      IndividualBar(x: 1, y: monDosage),
      //tue
      IndividualBar(x: 2, y: tueDosage),
      //wed
      IndividualBar(x: 3, y: wedDosage),
      //thur
      IndividualBar(x: 4, y: thuDosage),
      //fri
      IndividualBar(x: 5, y: friDosage),
      //sat
      IndividualBar(x: 6, y: satDosage),
    ];
  }
}
