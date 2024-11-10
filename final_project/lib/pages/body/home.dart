import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart";
import "package:latlong2/latlong.dart";
import "/api/tree.dart";

class Home extends StatefulWidget {
   @override 
   _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   LatLng? treeLocation;

   @override
   Widget build(BuildContext context) {
     return LayoutBuilder(
      builder: (context, constraints) {
         return Column(   
            children: [

               Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                     children: [
                        Text("Search by tree ID:  "),
                        Container(  
                           width: 200,
                           // Change to TextBox
                           child: TextField( 
                              onSubmitted: (id) {
                                 searchTree(id);
                              },
                           )
                        )
                     ]
                  )
               ),

               Expanded(
                  child: FlutterMap(
                     options: MapOptions(
                        initialCenter: treeLocation ?? const LatLng(35.100232, -92.440290),
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

   Future<void> searchTree(String id) async {
      try {
      Tree tree = await fetchTree(int.parse(id));
      setState(() {
         treeLocation = LatLng(
            double.parse(tree.latitude),
            double.parse(tree.longitude),
         );
         print(treeLocation); // Show fetch works
      });
    } catch (e) {
      print("Error fetching tree: $e");
    }
   }
}