import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
        title: Header("Report")
      ),
      body: Text('Coming Soon!')   
    );
    
    
  }
}
