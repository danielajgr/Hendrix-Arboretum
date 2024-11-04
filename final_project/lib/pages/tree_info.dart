import 'package:flutter/material.dart';
//import 'package:final_project/lib/api/tree.dart';

class TreeInfo extends StatefulWidget {
  TreeInfo({super.key, required this.treeid});
  //will need to know the tree?
  final int treeid;
  @override
  State<TreeInfo> createState() => _TreeInfoState();
}

class _TreeInfoState extends State<TreeInfo> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar
    (title: const Text("Tree Info"),
    ),
      body: ListView(padding: const EdgeInsets.all(50), children: [
      
          
          
          const Text('Very nice tree!', textAlign: TextAlign.center),
          Container( height: 200, decoration: const BoxDecoration(color: Colors.green)),
          ],
      ),
    );
  }
}