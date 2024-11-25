import "package:audioplayers/audioplayers.dart";
import "package:final_project/widgets/widgets.dart";
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
        Expanded(child: Stack(children: [
          Positioned.fill(
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
              Stack(children: [
                MarkerLayer(
                  markers: [
                    Marker(
                        point: treeLocation!,
                        width: 60,
                        height: 60,
                        child: GestureDetector(
                          onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TreeInfo(treeid: tree!.id)))
                            },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(Icons.location_on,
                                color: Color.fromARGB(255, 202, 81, 39),
                                size: 50),
                          ),
                        )),
                  ],
                ),
                 ])
            ])),
          Row(
            children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  height: 55,
                  child: TextField(
                    decoration:  InputDecoration(
                      label: Text("Search by Tree ID:", style: Theme.of(context).textTheme.labelLarge,),
                      fillColor: Color.fromARGB(255, 188, 159, 128),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)), 
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)), 
                        borderSide: BorderSide(color: Colors.grey), 
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)), 
                        borderSide: BorderSide(color: Colors.black), 
                      ),
                    ),
                    onSubmitted: (id) {
                      searchTree(id, false);
                    },
                  ),
                ),
              ),
              IconButton(icon: Image.asset(
                          "assets/dice.png",
                          width: 24,
                          height: 24),
                          onPressed: (){
                            searchTree("", true);
                          },
                          style: IconButton.styleFrom(backgroundColor: const Color.fromARGB(255, 188, 159, 128)))
            ],
          ),
        ],)
        ,)
        
        
        
      ]);
    });
  }

  Future<void> searchTree(String id, bool rand) async {
    final AudioPlayer _audioPlayer = AudioPlayer();
    try {
      if (!rand){
        tree = await fetchTree(int.parse(id));
      }else{
        tree = await fetchRandomTree();
      }
      
      setState(()  {
        if (tree != null) {
          treeLocation = LatLng(tree!.latitude, tree!.longitude);

               _audioPlayer.play(AssetSource('audio/ding.mp3'));
               ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: Text('You found a Tree!',textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge,), backgroundColor:  const Color.fromARGB(255, 0, 103, 79)),
        );
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
                    Navigator.of(context).pop(),
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
