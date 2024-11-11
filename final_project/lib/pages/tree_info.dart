import 'package:final_project/api/tree.dart';
import 'package:flutter/material.dart';




class TreeInfo extends StatefulWidget {
  TreeInfo({super.key, required this.treeid});
  //will need to know the tree?
  final int treeid;
  @override
  State<TreeInfo> createState() => _TreeInfoState();
}

/*FutureBuilder<Tree>(
  future: fetchTree,
  builder: (context, snapshot) {
    if(snapshot.hasData){

    }
  }
)**/

class _TreeInfoState extends State<TreeInfo> {
  late Future<Tree> futureTree;
  @override
  void initState() {
    super.initState();
    futureTree = fetchTree(widget.treeid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color.fromARGB(255, 175, 225, 175),
      appBar: AppBar
    (title: Text("Tree #${widget.treeid}", style: Theme.of(context).textTheme.displayMedium), backgroundColor: Color.fromARGB(255, 0, 103, 79), actions: [
      IconButton(icon: Icon(Icons.favorite),
        onPressed: () async {
            },
            )]
    ),
      body: ListView(padding: const EdgeInsets.all(50), children: [

          
           FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                if(snapshot.data!.imageURL == "/assets/img/stockTree.jpg"){
                  return Image.asset('unavailabletree.jpg');
                }
                else{
                  return Image.network(snapshot.data!.imageURL);  
                }
                
              } else if (snapshot.hasError) {
                return Image.asset('unavailabletree.jpg');
              }
                return Center (
                  child: Container(margin: EdgeInsets.symmetric( vertical: 100),  height: 50, width: 50, child: 
                  CircularProgressIndicator(color: Color.fromARGB(255, 0, 103, 79),),
                ));
              },
           ),

           Card(color: Color.fromARGB(255, 0, 103, 79), child: Column(children: [
             const Text('Common Name', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18) /*style: TextStyle(),**/),
            FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!.commonName, style: TextStyle(color: Colors.white));
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                return const Text("");
              }
              ),
           
            //const Text('Pine, Loblolly', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
          ],)
          ),
           Card(color: Color.fromARGB(255, 0, 103, 79), child: Column(children: [
            const Text('Scientific Name', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18) /*style: TextStyle(),**/),
            FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!.scientificName, style: TextStyle(color: Colors.white));
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                return Text('');
              }
              ),
          ],)
          ),

        Card(color: Color.fromARGB(255, 0, 103, 79), child: Column(children: [
            const Text('Building', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18) /*style: TextStyle(),**/),
            FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!.buildingName, style: TextStyle(color: Colors.white));
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                return Text('');
              }
              ),
          ],)
          )
          
          ],
      ),

      
    );
  }
}

