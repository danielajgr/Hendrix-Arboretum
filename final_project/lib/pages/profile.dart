import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget{
  Profile({required this.user});

  User user;

  

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Coming Soon')

    );
  }
}