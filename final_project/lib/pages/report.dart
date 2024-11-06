import 'package:final_project/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "/pages/leaderboard.dart";

class Report extends StatefulWidget{
  Report({super.key});


  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: Text('Coming Soon!')   
    );
    
    
  }
}