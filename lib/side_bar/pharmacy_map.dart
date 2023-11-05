// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
/*
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
*/
class PharmacyMap extends StatefulWidget {
  const PharmacyMap({super.key});

  @override
  State<PharmacyMap> createState() => _PharmacyMapState();
}

class _PharmacyMapState extends State<PharmacyMap> {
  @override
  Widget build(BuildContext context) {
    /*return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
           /* TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),*/
          ],
        ),
      ],
    )
    */
    return Column(
      children: const [],
    );
  }
}
