import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

class Home extends StatelessWidget {

   @override
   Widget build(BuildContext context) {
      return LayoutBuilder(
         builder: (context, constraints) {
            return Column(   
               children: [

                  // Filtering options eventually
                  const FloatingActionButton(
                     onPressed: null
                  ),
                  const FloatingActionButton(
                     onPressed: null
                  ),
                  const FloatingActionButton(
                     onPressed: null
                  ),

                  Expanded(
                     child: FlutterMap(
                        options: const MapOptions(
                           initialCenter: LatLng(35.100232, -92.440290),
                           // initialCenter: LatLng(35.100284, -92.440724),
                           // initialCenter: LatLng(35.100284, -92.441645),
                           initialZoom: 16
                        ),
                        children: [
                           TileLayer(
                              // https://docs.fleaflet.dev/
                              // Tilemap can be changed eventually
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                           )
                        ]
                     )
                  )
               ]
            );
         }
      );
   }
}