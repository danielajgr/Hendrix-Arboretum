import 'package:final_project/app_state.dart';
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/body/leaderboard.dart';
import 'package:final_project/pages/main_scaffold.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
  
  
}

class _ProfileState extends State<Profile> {
  var appState;


  List<TreeObject> trees = [];

  List treeIds = [];

  bool inList(TreeObject tree, List list){
    for(var item in list){
      if(item.treeid == tree.treeid){
        return true;
      }
      else{
        if(list.isEmpty){
          return false;
        }
      }
    }
    return false;
  }
  int findDuplicate(TreeObject tr, List<TreeObject> listTr){
    int index = 0;
    for(var t in listTr){
      if(t.treeid == tr.treeid){
        return index;
      }
      else{
        index++;
      }
    }
    return index;


  }

  List<TreeObject> getTrees(List ids){
    List<TreeObject> ts = [];
    for(var id in ids){
      TreeObject t = TreeObject(treeid: id);
      if(inList(t, ts) == false){
        t.add_like();
        ts.add(t);
        
      }
      else{
        int i = findDuplicate(t, ts);
        ts[i].add_like();
      }
    }
    return ts;
  } 

  @override
  void initState() {
    appState = context.read<ApplicationState>();
    treeIds = appState.getAll();
    trees = getTrees(treeIds);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 225, 175),
      appBar: AppBar(
        title: Text("Profile",style: Theme.of(context).textTheme.displayMedium),
        backgroundColor: const Color.fromARGB(255, 0, 103, 79),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/'); 
          },
        ),
      ),
      body: ProfileScreen(
        providers: const [],
        actions: [
          SignedOutAction((context) {
            context.pushReplacement('/');
          }),
        ],
        children: [
          Container(
            child: Text("Your Liked Trees"),
          ),
          ListView(
            shrinkWrap: true,
      children: trees.map((item) {
        return ListTile(
          title: Text("Tree #" + item.treeid.toString()),
          trailing: Text(item.likes.toString()),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TreeInfo(
                  treeid: item.treeid,
                ),
              ),
            );
          },
        );
      }).toList(),
    )

        ]
        ),
        

        
      );

          
    
  }
}
