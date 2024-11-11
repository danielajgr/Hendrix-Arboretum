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
  Widget? pageBody;
  String? pageTitle;

  int pageIndex = 1;

  List<TreeObject> testingTrees = [TreeObject(treeid: 0), TreeObject(treeid: 1), TreeObject(treeid: 2)];
  //list for leaderboard until data gets pulled from firebase


  @override
  void initState() {
    _onItemTapped(pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: pageBody,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 139, 69, 19),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
      pageIndex = index;

      // TODO: see if creating these page bodies every time matters
      var (pageBody, pageTitle) = switch (index) {
        0 => (
            Leaderboard(trees: testingTrees),
            "Leaderboard"

          ), // TODO: replace this null when you create the Leaderboard body widget
        1 => (Map(), "Hendrix Arboretum"),
        2 => (About(), "About"),
        _ => (null, null)
      };

      this.pageBody = pageBody;
      this.pageTitle = pageTitle;
    });
  }
}
