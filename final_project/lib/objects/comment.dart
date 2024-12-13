import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({required this.name, required this.message, required this.time});

  final String name;
  final String message;
  final int time;
  
  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(name: doc['name'], message: doc['message'], time: doc['timestamp']);
  }


}

