import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({required this.name, required this.message});

  final String name;
  final String message;
  
  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(name: doc['name'], message: doc['message']);
  }


}

