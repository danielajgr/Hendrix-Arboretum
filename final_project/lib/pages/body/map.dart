import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "/api/tree.dart";

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng? treeLocation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(children: [
        Row(
          children: [
            Text("Search by Tree ID:  "),
            Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                    width: 150,
                    height: 60,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (id) {
                        searchTree(id);
                      },
                    ))),
          ],
        ),
        Expanded(
            child: FlutterMap(
                options: MapOptions(
                    initialCenter:
                        treeLocation ?? const LatLng(35.100232, -92.440290),
                    initialZoom: 16),
                children: [
              TileLayer(
                  // https://docs.fleaflet.dev/
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png' // Should change
                  ),
              if (treeLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: treeLocation!,
                      width: 60,
                      height: 60,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Icon(Icons.location_on,
                            color: Color.fromARGB(255, 202, 81, 39), size: 50),
                      ),
                    ),
                  ],
                ),
            ]))
      ]);
    });
  }

  Future<void> searchTree(String id) async {
    try {
      Tree tree = await fetchTree(int.parse(id));
      setState(() {
        treeLocation =
            LatLng(double.parse(tree.latitude), double.parse(tree.longitude));
      });
    } catch (e) {
      print("Error fetching tree: $e");
    }
  }
}
