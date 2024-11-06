import 'package:final_project/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "/pages/leaderboard.dart";

class About extends StatefulWidget{
  About({super.key});

  

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('About'),
        ),
         body: Text('Coming Soon!'),

          //might not want to use elevated buttons idk
          //needs to be made pretty
         persistentFooterButtons: [
          IconButton(onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Leaderboard(
                topTrees: []
              ),
            ),
          );
        },
        icon: const Icon(Icons.leaderboard),),
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