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
         body: Text('Coming Soon!')
    );
  }
}