import "package:collection/collection.dart";
import 'package:final_project/app_state.dart';
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/authentication.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({super.key});

  
  @override
  State<Leaderboard> createState() => _LeaderboardState();}


class _LeaderboardState extends State<Leaderboard> { 

  @override
  Widget build(BuildContext context) {
    int rank = 0;

    return Consumer<ApplicationState>(
          builder: (context, appState, _) => 
      ListView(
        
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: 
        
        
        (appState.getTopTrees()).map((item) {//appstate gives top ten trees
        
        
        if(item.treeid == 0000){
          rank = 0;
          return  Column(
          children: [
    // First ListTile (with headings)
          ListTile(
            shape: Border(
            bottom: BorderSide(color: Color.fromARGB(255, 0, 48, 37), width: 1),
            ),      
            leading: Text(
            "Rank",
            style: Theme.of(context).textTheme.bodyMedium,),
            title: TextAndIcon(
            Icons.forest,
            "Top 10 Trees",
            25,
            ),
            trailing: Text(
            "Likes",
            style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
    
    // Image placed between ListTiles
          Image.asset(
            'assets/breaker.PNG',
            width: double.infinity, // Stretch to match parent width
            height: 60, // Adjust height as needed
            fit: BoxFit.fill,
          ),
        ]);
      }

      else{
        rank++;
        return ListTile(
          shape: const Border(
          top: BorderSide(color: Color.fromARGB(255, 0, 48, 37), width: 1),
          ), 

          contentPadding: const EdgeInsets.all(8.0),
          leading: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              'assets/tree_icon.PNG',
              width: 80,
              height: 200,
              fit: BoxFit.fill,
            ),
            Text(rank.toString(),style: Theme.of(context).textTheme.headlineLarge, )]),
            

          title: Text(
            "Tree #${item.treeid}",
            style: const TextStyle(fontSize: 25)
            ),

          trailing: Stack(
          alignment: Alignment.center,
          children: <Widget>[
          Icon(Icons.favorite, color: Colors.green, size: 40,),
          
          Text(
          "${item.likes}",
          style: Theme.of(context).textTheme.headlineMedium,
        )]),
        
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TreeInfo(
                  treeid: item.treeid,),
              ),
            );
          },
        );
      }}).toList(),
      ),

    );
  }
}
