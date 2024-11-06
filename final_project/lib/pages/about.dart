import 'package:flutter/material.dart';
import 'home.dart';  
import 'leaderboard.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('assets/about_tree.jpg'),
              Container(
                color: Colors.black54,
                child: const Text(
                  "Hendrix Arboretum",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/oak_tree.jpeg',
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column( children: [ 
                  Text("The Hendrix College Campus Arboretum",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Consistent with its community orientation and the educational goals of Hendrix College, the development of the campus arboretum was intended to provide an educational center for not only Hendrix College, but for the other colleges, public schools, and the general public in the Central Arkansas area, as well as for other visitors to the college.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),

            ])
              ),
            ],
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Column( children: [ 
                  Text("Locate a Tree Tag",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Each tree in the arboretum can be identified with a numbered circular metallic tag, found on the south side of the tree. Enter the ID number in the search field below to learn more information about the tree.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),])
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/tree_tag.jpg',
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
              ),
            ],
          )
        ],
      ),
      persistentFooterButtons: [
        IconButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Leaderboard(
                  topTrees: [], 
                ),
              ),
            );
          },
          icon: const Icon(Icons.leaderboard),
        ),
        ElevatedButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
          child: const Icon(Icons.home),
        ),
      ],
    );
  }
}
