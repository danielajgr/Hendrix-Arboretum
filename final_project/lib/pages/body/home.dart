import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

class Home extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
      return FlutterMap(
         options: MapOptions(
            initialCenter: LatLng(35.100284, -92.441645),
            initialZoom: 16
         ),
         // https://docs.fleaflet.dev/
         children: [
            TileLayer(
               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
               userAgentPackageName: 'com.example.app',
            )
         ]
      );
   }
}