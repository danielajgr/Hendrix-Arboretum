import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/api/tree.dart';
import 'package:final_project/app_state.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:final_project/objects/comment.dart';




class TreeInfo extends StatefulWidget {
  TreeInfo({super.key, required this.treeid, commonname});
  //will need to know the tree?
  final int treeid;
  String commonname = 'tree';
  //late Future<List<Comment>> cmts;
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
  var appState;
  @override
  void initState() {
    super.initState();
    futureTree = fetchTree(widget.treeid);
    appState = context.read<ApplicationState>();
    //widget.cmts = appState.loadComments(widget.treeid);
    //appState.loadComments(widget.treeid);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      backgroundColor: const Color.fromARGB(255, 175, 225, 175),
      appBar: AppBar
    (title: Text("Tree #${widget.treeid}", style: Theme.of(context).textTheme.displayMedium), backgroundColor: Color.fromARGB(255, 0, 103, 79), actions: [
      IconButton(
      icon: Icon(Icons.favorite),
      color: appState.isFavorite(widget.treeid) ? Color.fromARGB(255, 255, 0, 0) : Color(0xff9A9A9A),
      onPressed: () async {
        if (!appState.loggedIn) {
            context.push('/sign-in');
        }if(appState.isFavorite(widget.treeid)){
                  setState(() {
                  appState.removeTree(widget.treeid);
                });}
                else{
                  setState(() {
                  appState.addTree(widget.treeid);
                  });
                }
                
      },
    )]
    ),
      body: ListView(padding: const EdgeInsets.only(left: 50, right: 50, top: 50), shrinkWrap: true, children: [

          
           FutureBuilder<Tree>(
              future: futureTree,
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return CachedNetworkImage(
                  imageUrl: snapshot.data!.imageURL,
                    
                    placeholder: (context, url) => Center(
                      child: Container(margin: EdgeInsets.symmetric( vertical: 100),  height: 75, width: 75,
                        child: const CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 103, 79),
                        )
                      )
                    )  
                  
                );
                   
                
                
              } else if (snapshot.hasError) {
                return Image.asset('img/stockTree.jpg');
              }
                return Center (
                  child: Container(margin: EdgeInsets.symmetric( vertical: 100),  height: 75, width: 75, child: 
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
                widget.commonname = snapshot.data!.commonName;
                if(widget.commonname.contains(',')){
                  widget.commonname = widget.commonname.split(',')[1] + ' ' + widget.commonname.split(',')[0];
                }
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
          ),
        FutureBuilder<Tree>(
            future: futureTree,
            builder: (context, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data!.height != 0.0){
                return Card(color: Color.fromARGB(255, 0, 103, 79), child: Column(children: [
                const Text('Height', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                Text("${snapshot.data!.height}", style: TextStyle(color: Colors.white)),
                ],
              ));
              }
                
            }else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
              return Text('');
            }
        ),

          FutureBuilder<Tree>(
            future: futureTree,
            builder: (context, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data!.dbh != 0.0){
                return Card(color: Color.fromARGB(255, 0, 103, 79), child: Column(children: [
                const Text('DBH', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                Text("${snapshot.data!.dbh}", style: TextStyle(color: Colors.white)),
                ],
              ));
              }
                
            }else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
              return Text('');
            }
            ),
          
          Container(padding: EdgeInsets.only(top:50, left: 80, right: 80, bottom: 10), child:
          ElevatedButton(onPressed: () => {_launchurl(Uri.parse('https://plants.ces.ncsu.edu/find_a_plant/common-name/?q=${widget.commonname}'))}
          , child: Text('More Info'))
          ),
          
          //widget.cmts = appState.getComments(widget.treeid);
          //Text(appState.loadComments(widget.treeid).length.toString()),
          CommentSection(addComment: (id, comment) => appState.addComment(id, comment), treeID: widget.treeid)
          ],
      ),

      
    );
  }

  Future<void> _launchurl(Uri url) async {
  if(!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

}

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.addComment, required this.treeID});

  final Future<void> Function(int id, String comment) addComment;
  //final Future<List<Comment>> Function(int id) getComment;
  //final Future<List<Comment>> comments;
  final int treeID;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: '_CommentSectionState');
  List<Comment> _comments = [];
  @override
  void initState() {
    super.initState();
    _fetchcmts();
  }

  Future<void> _fetchcmts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      final _firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await _firestore
        .collection('treeComments')
        .doc(widget.treeID.toString())
        .collection('comments')
        .get();
      _comments = snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
      _comments.sort((a, b) => b.time.compareTo(a.time));
    setState(() {
      
    });
    }
  }
  //late List result;
  //void getCmts(id) async{
   // result = await widget.getComment(id);
  //}
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ApplicationState>(
            builder: (context, appState, _)=> 
            Form(key: _formKey, child: Row(
              children: [
                if(appState.loggedIn)...[
                  Expanded(child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Leave a comment',
          ),
          validator: (value) {
            if(value == null || value.isEmpty){
              return 'Enter your message to continue';
            }
            print("no");
            return null;
          },
        )),
        StyledButton(child: Text('post'), 
        onPressed: () async{
          if(_formKey.currentState != null){
            if(_formKey.currentState!.validate()){
            await widget.addComment(widget.treeID, _controller.text);
            _fetchcmts();
            setState(() {
              
            });
            _controller.clear();
            }
          }
          
        })
                ]
              ],
            ), 
          ),

          ),
        const SizedBox(height: 20),
        
        Consumer<ApplicationState>(
            builder: (context, appState, _)=> Column(children: [
              if(appState.loggedIn)...[
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index){
                    return SizedBox(height: 5);
                  },
                  shrinkWrap: true, itemCount: _comments.length, 
                  itemBuilder: (context, index){
                    return ColoredBox(color: Colors.white, child: Column(children: [
                      ListTile( isThreeLine: true,
                        title: Text('${_comments[index].name}'), subtitle: Text('${_comments[index].message}')
                      ),
                      Row(children: [Expanded(child: Container()), if(FirebaseAuth.instance.currentUser?.displayName == _comments[index].name)...[
                        StyledButton(onPressed: (){
                          appState.deleteComment(widget.treeID, _comments[index]);
                          _fetchcmts();
                          setState(() {
                            
                          });
                        }, child: Icon(Icons.delete))],
                        StyledButton(onPressed: (){}, child: Icon(Icons.report))
                      ],)
                    ])
                    );
                  } 
                )
              ] else...[
                const Text('Sign in to see comments!')
              ]
            ],)),
       
        //for (Comment comment in widget.comments)
         // Text('${comment.name}: ${comment.message}', style: TextStyle(color: Colors.black), ),
        //const SizedBox(height: 8),
        
      ],
    );
  }
}


