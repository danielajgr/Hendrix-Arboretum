import 'dart:collection';

import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';


class Leaderboard extends StatelessWidget {
  Leaderboard({required this.trees});

  final List<TreeObject> trees;

  ListQueue<TreeObject> topTenTrees = ListQueue(1);

  //adding likes to the testing trees list
  //adds two likes to first tree, one to the second, and none to the third
  void testAddingLikes(){
    trees[0].add_like();
    trees[1].add_like();
    trees[0].add_like();
  }

  void getTopTen(){
    topTenTrees.addFirst(trees[0]);

    for(var tree in trees){
      if(tree.get_likes() >= topTenTrees.first.get_likes()){
        topTenTrees.addFirst(tree);
      }
      else{
          topTenTrees.addLast(tree);
        }
      }

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