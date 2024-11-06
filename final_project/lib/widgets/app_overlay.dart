import "package:final_project/app_state.dart";
import "package:final_project/widgets/authentication.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "/pages/about.dart";
import "/pages/home.dart";
import "/pages/leaderboard.dart";
import "/pages/profile.dart";
import "/pages/report.dart";





class AppOverlay extends StatefulWidget {
  AppOverlay(
    this.pageTitle,
    this.pageIndex,
    this.pageBody
  );

  final String pageTitle;
  int pageIndex;
  final Widget? pageBody;

  @override 
  _AppOverlayState createState() => _AppOverlayState();
}

class _AppOverlayState extends State<AppOverlay> {


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
      title: Text(widget.pageTitle),
      actions: [
        IconButton(
          icon: Icon(Icons.report),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
        ],
        currentIndex: widget.pageIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
    });
  if (index != widget.pageIndex) {
    switch (index) {
      case 0:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Leaderboard(
              topTrees: [],
            ),
          ),
        );
        break;
      case 1: 
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Home(
            ),
          ),
        );
        break;
      case 2:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => About(
            ),
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
