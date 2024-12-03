import 'package:final_project/app_state.dart';
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  
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
          const Padding(padding: EdgeInsets.all(5)),
          Container(
            padding: const EdgeInsets.all(1),
            child: const TextAndIcon(Icons.forest, "Your Liked Trees", 30
            ),),
          
          const Padding(padding: EdgeInsets.only(top: 10)),

          Consumer<ApplicationState>(
          builder: (context, appState, _) => 
          ListView(
            padding: EdgeInsets.all(0.8),
            shrinkWrap: true,
            children: appState.getAll().map((item) {
            return ListTile(
              shape: const Border(
              top: BorderSide(color: Color.fromARGB(255, 134, 72, 20), width: 1),
              ),
              title: Text("Tree #" + item.treeid.toString()),
              trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: appState.isFavorite(item.treeid) ? Color.fromARGB(255, 255, 0, 0) : Color(0xff9A9A9A),
              onPressed: () async {
                if (!appState.loggedIn) {
                  context.push('/sign-in');
                }else{
                if(appState.isFavorite(item.treeid)){
                  setState(() {
                  appState.removeTree(item.treeid);
                });}
                else{
                  setState(() {
                  appState.addTree(item.treeid);
                  });
                }
                }},
              ),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TreeInfo(treeid: item.treeid),
              ),
            );
          },
        );
      }).toList()),
          ),
    ]), 
  );
}}
