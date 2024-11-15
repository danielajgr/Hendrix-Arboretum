import "package:collection/collection.dart";

import 'package:final_project/api/tree.dart';
import 'package:final_project/app_state.dart';
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Leaderboard extends StatefulWidget {
  Leaderboard({required this.trees, required this.userTrees});
  final List<TreeObject> trees;
  final bool userTrees;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late Future<Tree> futureTree;
  PriorityQueue<TreeObject> treeQueue = PriorityQueue();

  List<TreeObject> topTenTrees = [];
  
  // TEMP TO SHOW CORRECT ORDERING:
  List<TreeObject> likeList = [TreeObject(treeid: 100000)
    , TreeObject(treeid: 100001)
    , TreeObject(treeid: 100002)
    ];

  @override
  Widget build(BuildContext context) {
    // TEMP TO SHOW CORRECT ORDERING (delete when likes fully work):
    // ----------------------------------------------
    for (int i = 0; i < 3; i++) {
      likeList[i].likes = 10 + i;
    }
    treeQueue.addAll(likeList);
    // ----------------------------------------------


    treeQueue.addAll(widget.trees);


    for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
      topTenTrees.add(treeQueue.removeFirst());
    }

    // var appState = context.read<ApplicationState>();
    // if(!appState.loggedIn){
    //   return Container(
    //     child: Text('Log in to See Our Top Trees')
    //   );
    // }

    // if(!widget.userTrees){
    //   widget.getTopTen();
    // }

    int rank = 0;

    return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: 
          topTenTrees.map((item) {
            rank++;
          //var futureTree = fetchTree(item.get_treeId());
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 5, 87, 47),
                child: Text(rank.toString()),
              ),
              title: Text("Tree #" + item.treeid.toString()),
              trailing: Text(item.likes.toString()),
              onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TreeInfo(treeid: item.treeid,
                
              ),
            ),
      
          );
        },
              
            );
          }).toList(),
    
        
      
    );
    
  }
  
  
}