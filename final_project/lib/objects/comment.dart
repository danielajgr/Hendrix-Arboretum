import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({required this.name, required this.message, required this.time, required this.commentid, required this.userid});

  final String name;
  final String message;
  final int time;
  final String commentid;
  final String userid;
  
  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(name: doc['name'], message: doc['message'], time: doc['timestamp'], commentid: doc.id, userid: doc['userid']);
  }


}

