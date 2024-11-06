import 'package:final_project/pages/about.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;    // new
import 'package:flutter/material.dart';           // new
import 'package:provider/provider.dart';          // new

import '../app_state.dart';                          // new
import '../widgets/authentication.dart';                 // new
import '../widgets/widgets.dart';

import "/pages/leaderboard.dart";
import "/pages/profile.dart";
import "/pages/report.dart";
import "/pages/about.dart";


class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

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
    case 2:
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => About(
          ),
        ),
      );
      break;
    default:
    // Already on home page
      break;
   }
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hendrix Arboretum"),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                builder: (context) => Report(
                ),
              ),
              );
            }
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.account_circle_rounded),
          iconSize: 40,
          onPressed: () async { 
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Leaderboard(
                  topTrees: [],
                ),
              ),
            );
        }
      )
      ),
      body: ListView(
        children: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
        
  }
}

  
