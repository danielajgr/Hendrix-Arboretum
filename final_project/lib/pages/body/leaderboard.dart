import "package:collection/collection.dart";
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key, required this.trees});
  final List<TreeObject> trees;

  @override
  State<Leaderboard> createState() => _LeaderboardState();}


class _LeaderboardState extends State<Leaderboard> {
  PriorityQueue<TreeObject> treeQueue = PriorityQueue();
  List<TreeObject> topTenTrees = [];

  @override
  void initState() {
    super.initState();
    if(topTenTrees.isEmpty){
      treeQueue.addAll(widget.trees);
      for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
        topTenTrees.add(treeQueue.removeFirst());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    int rank = 0;
    if(topTenTrees.isEmpty){
    treeQueue.addAll(widget.trees);
      for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
        topTenTrees.add(treeQueue.removeFirst());
      }
    }
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: topTenTrees.map((item) {
        rank++;
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
                builder: (context) => TreeInfo(
                  treeid: item.treeid,),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
