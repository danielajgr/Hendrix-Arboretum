import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "/api/tree.dart";
import "/pages/tree_info.dart";

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng? treeLocation;
  Tree? tree;
  MapController mapController = MapController();

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
               mapController: mapController,
                options: MapOptions(
                    initialCenter:
                        treeLocation ?? const LatLng(35.100232, -92.440290),
                    initialZoom: 16),
                children: [
              TileLayer(
                  // https://docs.fleaflet.dev/
                  urlTemplate:
                      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}' // Should change
                  ),
              const SimpleAttributionWidget(
                  source: Text("Tiles - Esri", softWrap: true)),
              // Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community
              if (treeLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                        point: treeLocation!,
                        width: 60,
                        height: 60,
                        child: GestureDetector(
                          onTap: () => markerPopup(context),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(Icons.location_on,
                                color: Color.fromARGB(255, 202, 81, 39),
                                size: 50),
                          ),
                        )),
                  ],
                ),
            ]))
      ]);
    });
  }

  Future<void> searchTree(String id) async {
    try {
      tree = await fetchTree(int.parse(id));
      setState(() {
        if (tree != null) {
          treeLocation = LatLng(
              double.parse(tree!.latitude), double.parse(tree!.longitude));
        }
        mapController.move(treeLocation!,18);
      });
    } catch (e) {
      print("Error fetching tree: $e");
    }
  }

  void markerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tree #${tree!.id}"),
          content: ElevatedButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TreeInfo(treeid: tree!.id)))
                  },
              child: const Text("Tree page")),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
