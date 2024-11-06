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
      // await Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => About(
      //     ),
      //   ),
      // );
      break;
    default:
    // Already on home page
      break;
   }
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hendrix Arboretum")),
      body: ListView(
        children: <Widget>[
          
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          // to here
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "TEMP"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
        
  }
}

  
