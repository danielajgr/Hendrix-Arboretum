import 'dart:collection';

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

  List<TreeObject> topTenTrees = [];

  

  

  bool inList(TreeObject tree, List list){
    for(var item in list){
      if(item.get_treeId == tree.get_treeId){
        return true;
      }
    }
    return false;
  }

  void getTopTen(){
    int max = 0;
    int second = 0;
    int third = 0;
    int fourth = 0;
    int fifth = 0;
    int sixth = 0;
    int seventh = 0;
    int eighth = 0;
    int ninth = 0;
    int tenth = 0;

    if(trees.length > 0){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[0].remove_Like();
      max = topTenTrees[0].get_likes();
      for(var tree in trees){
        if(tree.get_likes() > max){
          topTenTrees[0] = tree;
          max = tree.get_likes();
        }
        
      }
      
      
    }

    if(trees.length > 1){
      topTenTrees.add(TreeObject(treeid: 200000000));
      topTenTrees[1].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= max) 
        & (tree.get_likes() >= second) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[1] = tree;
          second = tree.get_likes();
        }
      }
    }

    if(trees.length > 2){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[2].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= second) 
        & (tree.get_likes() >= third) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[2] = tree;
          third = tree.get_likes();
        }
      }
    }
    if(trees.length > 3){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[3].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= third) 
        & (tree.get_likes() >= fourth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[3] = tree;
          fourth = tree.get_likes();
        }
      }
    }
    if(trees.length > 4){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[4].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= fourth) 
        & (tree.get_likes() >= fifth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[4] = tree;
          fifth = tree.get_likes();
        }
      }
    }


    if(trees.length > 5){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[5].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= fifth) 
        & (tree.get_likes() >= sixth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[5] = tree;
          sixth = tree.get_likes();
        }
      }
    }

    if(trees.length > 6){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[6].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= sixth) 
        & (tree.get_likes() >= seventh) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[6] = tree;
          seventh = tree.get_likes();
        }
      }
    }

    if(trees.length > 7){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[7].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= seventh) 
        & (tree.get_likes() >= eighth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[7] = tree;
          eighth = tree.get_likes();
        }
      }
    }

    if(trees.length > 8){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[8].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= eighth) 
        & (tree.get_likes() >= ninth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[8] = tree;
          ninth = tree.get_likes();
        }
      }
    }

    if(trees.length > 9){
      topTenTrees.add(TreeObject(treeid: 20000000));
      topTenTrees[9].remove_Like();
      for(var tree in trees){
        if((tree.get_likes() <= ninth) 
        & (tree.get_likes() >= tenth) 
        & (inList(tree, topTenTrees) == false)){
          topTenTrees[9] = tree;
          tenth = tree.get_likes();
        }
      }
    }
    }

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late Future<Tree> futureTree;
  

  @override
  Widget build(BuildContext context) {
    if(!widget.userTrees){
      widget.getTopTen();
    }
   
    return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: widget.topTenTrees.map((item) {
          //var futureTree = fetchTree(item.get_treeId());

    
            return ListTile(
              title: Text("Tree " + item.get_treeId().toString()),
              /*FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!.commonName);
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                return const Text("");
              }
              ),*/
              trailing: Text(item.get_likes().toString()),
              onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TreeInfo(treeid: item.get_treeId(),
                
              ),
            ),
      
          );
        },
              
            );
          }).toList(),
        
      
    );
    
  }
  
  
}