import "package:cloud_firestore/cloud_firestore.dart";
import "package:final_project/app_state.dart";
import "package:final_project/objects/tree_object.dart";
import "package:final_project/pages/body/leaderboard.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../widgets/authentication.dart";
import "/pages/body/about.dart";
import "body/map.dart";
import "/pages/report.dart";

class MainScaffold extends StatefulWidget {
  const MainScaffold();

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int pageIndex = 1;

  @override
  void initState() {
    _onItemTapped(pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? pageTitle = [
      "Leaderboard",
      "Hendrix Arboretum",
      "About",
    ].elementAtOrNull(pageIndex);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 225, 175),
      appBar: AppBar(
        title: Text(pageTitle ?? "missingno",
            style: Theme.of(context).textTheme.displayMedium),
        backgroundColor: const Color.fromARGB(255, 0, 103, 79),
        actions: [
          IconButton(
            icon: const Icon(Icons.report),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Report(),
                ),
              );
            },
          ),
        ],
        leading: Consumer<ApplicationState>(
          builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              }),
        ),
      ),
      // This ended up working for keeping the map from reloading each time:
      // https://stackoverflow.com/a/54999503
      // https://api.flutter.dev/flutter/widgets/IndexedStack-class.html
      body: IndexedStack(
        index: pageIndex,
        children: const [
          Leaderboard(),
          Map(),
          About(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 139, 69, 19),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
        currentIndex: pageIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
      pageIndex = index;
    });
  }
}
