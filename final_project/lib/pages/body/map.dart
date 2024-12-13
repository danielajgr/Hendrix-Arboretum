import "package:audioplayers/audioplayers.dart";
import "package:final_project/api/by_name.dart";
import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";

import "/api/specialty.dart";
import "/api/tree.dart";
import "/pages/tree_info.dart";

class SearchResult {
  List<Tree> trees;

  SearchResult({required this.trees});
}

class Map extends StatefulWidget {
  const Map({required super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  MapController mapController = MapController();

  List<Specialty> specialtyList = [];
  Specialty? selectedSpecialty;

  SearchResult? searchResult;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getSpecialties();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: FlutterMap(
                    // key: UniqueKey(),
                    mapController: mapController,
                    options: const MapOptions(
                        initialCenter: LatLng(35.100232, -92.440290),
                        initialZoom: 16),
                    children: [
                      TileLayer(
                          // https://docs.fleaflet.dev/
                          urlTemplate:
                              'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}' // Should change
                          ),
                      const SimpleAttributionWidget(
                        source: Text("Tiles - Esri", softWrap: true),
                      ),
                      // Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community
                      if (searchResult case SearchResult res)
                        Stack(
                          children: [
                            MarkerLayer(
                              markers: createMarkers(res.trees),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                // Incredibly helpful reference:
                // https://dartling.dev/displaying-a-loading-overlay-or-progress-hud-in-flutter
                if (isLoading)
                  const Opacity(
                    opacity: 0.8,
                    child:
                        ModalBarrier(dismissible: false, color: Colors.black),
                  ),
                if (isLoading) const Center(child: CircularProgressIndicator()),
                Column(
                  children: [
                    buildStyledContainer(
                      Center(
                        child: DropdownButton<Specialty>(
                          value: selectedSpecialty,
                          hint: Center(
                            child: Text(
                              "Select a specialty",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          isExpanded: true,
                          items: specialtyList.map((Specialty item) {
                            return DropdownMenuItem<Specialty>(
                              value: item,
                              child: Center(
                                child: Text(item.title,
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              ),
                            );
                          }).toList(),
                          onChanged: (Specialty? newSpecialty) {
                            if (newSpecialty != null) {
                              selectedSpecialty = newSpecialty;
                              specialtyTrees(newSpecialty);
                            }
                          },
                          dropdownColor:
                              const Color.fromARGB(255, 188, 159, 128),
                        ),
                      ),
                    ),
                    buildStyledContainer(
                      ElevatedButton.icon(
                        onPressed: () {
                          fetchNearbyTrees();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 188, 159, 128),
                        ),
                        icon: const Icon(Icons.near_me, color: Colors.white),
                        label: Text(
                          "Find Nearby Trees",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        buildStyledContainer(
                          TextField(
                            decoration: InputDecoration(
                              label: Text(
                                "Search For Trees:",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              fillColor: Color.fromARGB(255, 188, 159, 128),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onSubmitted: (query) {
                              search(query);
                            },
                          ),
                        ),
                        IconButton(
                          icon: Image.asset("assets/dice.png",
                              width: 40, height: 40),
                          onPressed: () {
                            randomTree();
                          },
                          style: IconButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 188, 159, 128),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget buildStyledContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 300,
        height: 55,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 188, 159, 128),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }

  List<Marker> createMarkers(List<Tree> trees) {
    return trees
        .map(
          (tree) => Marker(
            point: LatLng(tree.latitude, tree.longitude),
            width: 60,
            height: 60,
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreeInfo(treeid: tree.id),
                  ),
                )
              },
              child: Container(
                alignment: Alignment.center,
                child: const Icon(Icons.location_on,
                    color: Color.fromARGB(255, 202, 81, 39), size: 50),
              ),
            ),
          ),
        )
        .toList();
  }

  Future<void> search(String text) async {
    try {
      setState(() {
        isLoading = true;
      });

      if (int.tryParse(text) case int id) {
        Tree? tree = await fetchTree(id);

        if (tree == null) {
          throw Exception("Could not find tree at id $id");
        }

        populateMap([tree], zoom: 18);
      } else {
        List<Tree> science = await fetchTreesBySpecies(false, text);
        List<Tree> common = await fetchTreesBySpecies(true, text);

        List<Tree> resultTrees = [];
        resultTrees.addAll(science);
        resultTrees.addAll(common);

        if (resultTrees.isEmpty) {
          throw Exception(
              "Could not find trees with common or scientific name of $text");
        }

        populateMap(resultTrees);
      }
    } catch (e) {
      noTreesFound();
    }
  }

  Future<void> randomTree() async {
    try {
      setState(() {
        isLoading = true;
      });

      Tree? tree = await fetchRandomTree();

      if (tree == null) {
        throw Exception("Failed to fetch random tree.");
      }

      populateMap([tree], zoom: 18);
    } catch (e) {
      noTreesFound();
    }
  }

  Future<void> fetchNearbyTrees() async {
    try {
      setState(() {
        isLoading = true;
      });

      await checkGeoPermissions();
      Position loc = await Geolocator.getCurrentPosition();

      List<Tree> treeList =
          await fetchClosestTrees(loc.latitude, loc.longitude, 5);

      populateMap(treeList, zoom: 18);
    } catch (e) {
      noTreesFound();
    }
  }

  Future<void> specialtyTrees(Specialty specialty) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Tree> trees = await fetchTreesForSpecialty(specialty);
      populateMap(trees);
    } catch (e) {
      noTreesFound();
      print("Error fetching specialty trees: $e");
    }
  }

  Future<void> checkGeoPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getSpecialties() async {
    try {
      List<Specialty> specialties = await fetchAllSpecialties();
      setState(() {
        specialtyList = specialties;
      });
    } catch (e) {
      print("Error fetching specialties");
    }
  }

  void populateMap(List<Tree> trees, {double zoom = 16}) {
    int len = trees.length;

    setState(() {
      searchResult = SearchResult(trees: trees);
      isLoading = false;
    });

    _audioPlayer.play(AssetSource('audio/ding.mp3'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          len == 1 ? 'You found a Tree!' : 'You found $len Trees!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 103, 79),
      ),
    );

    mapController.move(LatLng(trees[0].latitude, trees[0].longitude), zoom);
  }

  void noTreesFound() {
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No trees found!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 103, 79),
      ),
    );
  }
}
