import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import "/widgets/app_overlay.dart";

class About extends StatefulWidget{
  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  
  @override
  Widget build(BuildContext context) {
    return AppOverlay("About",2);
  }
}