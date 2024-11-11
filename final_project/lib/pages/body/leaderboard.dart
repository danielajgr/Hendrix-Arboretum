import 'dart:collection';

import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';


class Leaderboard extends StatelessWidget {
  Leaderboard({required this.trees});

  final List<TreeObject> trees;

  List<TreeObject> topTenTrees = [];
  

  //adding likes to the testing trees list
  //adds two likes to first tree, one to the second, and none to the third
  void testAddingLikes(){
    trees[0].add_like();
    trees[0].add_like();
    trees[1].add_like();
    trees[2].add_like();
    trees[2].add_like();
    trees[2].add_like();
    
  }

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
      topTenTrees.add(TreeObject(treeid: 2000000));
      topTenTrees[0].remove_Like();
      for(var tree in trees){
        if(tree.get_likes() > max){
          topTenTrees[0] = tree;
          max = tree.get_likes();
        }
      }
    }

    if(trees.length > 1){
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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
      topTenTrees.add(TreeObject(treeid: 2000000));
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

    



    /*
    topTenTrees.addFirst(trees[0]);

    for(var tree in trees){
      if(topTenTrees.isEmpty){
        topTenTrees.addFirst(trees[0]);
      }
      else{
        if(tree.get_likes() >= topTenTrees.first.get_likes()){
          topTenTrees.addFirst(tree);
      }
        if(tree.get_likes() >= topTenTrees.last.get_likes()){
          topTenTrees.addFirst(tree);
        }
      else{
          topTenTrees.addLast(tree);
        }
      }
    }*/

    }
    




  @override
  Widget build(BuildContext context) {
    testAddingLikes();
    getTopTen();
    return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: topTenTrees.map((item) {
            return ListTile(
              title: Text(item.get_treeId().toString()),
              subtitle: Text(item.get_likes().toString()),
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