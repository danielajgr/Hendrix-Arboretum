import 'package:flutter/material.dart';

import "/widgets/app_overlay.dart";

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // will need eventually  

  @override
  Widget build(BuildContext context) {
    return AppOverlay("Hendrix Arboretum",1,null);
  }
}

  
