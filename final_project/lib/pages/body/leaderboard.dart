import "package:collection/collection.dart";
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key, required this.trees});
  final List<TreeObject> trees;

  @override
  State<Leaderboard> createState() => _LeaderboardState();}


class _LeaderboardState extends State<Leaderboard> {
  PriorityQueue<TreeObject> treeQueue = PriorityQueue();
  List<TreeObject> topTenTrees = [TreeObject(treeid: 0000)];

  @override
  void initState() {
    super.initState();
    if(topTenTrees.length == 1){
      treeQueue.addAll(widget.trees);
      for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
        topTenTrees.add(treeQueue.removeFirst());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    int rank = -1;
    if(topTenTrees.length == 1){
    treeQueue.addAll(widget.trees);
      for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
        topTenTrees.add(treeQueue.removeFirst());
      }
    }
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: 
      

      topTenTrees.map((item) {
        if(rank < 0){
          rank++;

          return const ListTile(
            shape: Border(
            bottom: BorderSide(color: Color.fromARGB(255, 186, 81, 21), width: 5),
          ),
            leading: Text(
              "Rank",
              style: TextStyle(fontSize: 15)
            ),
            title: TextAndIcon( Icons.forest,
              "Top 10 Trees", 25
            ),
            trailing: 
              Text(
              "Likes",
              style: TextStyle(fontSize: 15),
            ),
        
          );
        }

        else{
        rank++;
        return ListTile(
          shape: const Border(
          top: BorderSide(color: Color.fromARGB(255, 8, 37, 2), width: 1),
          ), 

          contentPadding: const EdgeInsets.all(8.0),
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 5, 87, 47),
            child: Text(rank.toString()),
          ),

          title: Text(
            "Tree #${item.treeid}",
            style: const TextStyle(fontSize: 25)
            ),

          trailing: 
          Text(
          "${item.likes}       ",
          style: const TextStyle(fontSize: 20),
        ),
        
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

    );
  }
}
