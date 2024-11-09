import 'package:final_project/app_state.dart';
import 'package:final_project/pages/main_scaffold.dart';
import 'package:final_project/widgets/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget{

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 
  
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
              children: [
                Text("User's liked trees coming soon")
              ],
            
        
        
      
    );
  }
}
        
