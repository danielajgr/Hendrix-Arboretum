import 'package:flutter/material.dart';

class TreeInfo extends StatefulWidget {
  const TreeInfo({super.key});
  //will need to know the tree?
  @override
  State<TreeInfo> createState() => _TreeInfoState();
}

class _TreeInfoState extends State<TreeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar
    (title: const Text("Tree Info"),
    ),
      body: const SingleChildScrollView(child: 
        Column(children: 
          [
          Text('Very nice tree!')
          ],
        ),
      ),
    );
  }
}