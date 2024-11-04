import 'package:final_project/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Leaderboard extends StatefulWidget{
  Leaderboard({required this.topTrees});

  List topTrees; //list of trees
  

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Leaderboard'),
        ),
         body: Text('Coming Soon!'),
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
        //add when page is createe

         ]
          
          
    );
    
    
  }
}