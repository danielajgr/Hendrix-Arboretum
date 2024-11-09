import 'package:final_project/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  Profile({required this.user, required this.userTrees});

  User user;
  List userTrees; 

  

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Coming Soon'),

      //might not want to use elevated buttons idk
      //needs to be made pretty
      persistentFooterButtons: [
          ElevatedButton(onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Leaderboard(
                topTrees: [],
              ),
            ),
          );
        },
        child: const Icon(Icons.leaderboard),),
        ElevatedButton(onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(
              ),
            ),
          );
        },
        child: const Icon(Icons.home),),
        /*ElevatedButton(onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => About(
                topTrees: [],
              ),
            ),
          );
        },
        child: const Icon(Icons.info),),*/
        //add when page is created

         ]
    );
  }
}
