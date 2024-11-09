import "package:final_project/app_state.dart";
import "package:final_project/pages/authentication.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "/pages/about.dart";
import "/pages/home.dart";
import "/pages/leaderboard.dart";
import "/pages/report.dart";

class AppOverlay extends StatefulWidget {
  const AppOverlay({super.key});

  @override
  _AppOverlayState createState() => _AppOverlayState();
}

class _AppOverlayState extends State<AppOverlay> {
  Widget pageBody;
  String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 225, 175),
      appBar: AppBar(
        title: Text(widget.pageTitle,
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
      body: widget.pageBody,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 139, 69, 19),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
        currentIndex: widget.pageIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {});
    if (index != widget.pageIndex) {
      switch (index) {
        case 0:
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Leaderboard(
                topTrees: const [],
              ),
            ),
          );
          break;
        case 1:
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
          break;
        case 2:
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => About(),
            ),
          );
          break;
        default:
          // error
          break;
      }
    }
  }
}
