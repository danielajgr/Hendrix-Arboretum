import 'dart:math';

import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/authentication.dart';

class Report extends StatefulWidget {
  Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWrapper(
      title: "Report A Problem",
      body: ListView(children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('assets/missing.PNG'),
            Positioned(
              top: 200,
              child: ArcText(
                radius: 150,
                text: 'Is there a missing tag?',
                textStyle: Theme.of(context).textTheme.displayLarge,
                startAngle: -pi /1.48,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('assets/dam.PNG'),
            Positioned(
              top: 200,
              child: ArcText(
                radius: 150,
                text: "Is there a damaged tag?",
                textStyle: Theme.of(context).textTheme.displayLarge,
                startAngle:12 ,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
            ),
          ],
        ),
        
        
        
        Text("Click the button below to report any concerns!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge),
        SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 176, 39, 39),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30), 
            ),
            onPressed: () {
              _launchURL('https://forms.gle/QnkWZRu1437LN3RYA');
            },
            child:  Text("Report", style:TextStyle(
              color: Colors.white,
              fontFamily: 'MuseoBold',
              fontSize: 30,
            ),),
          ),],),

        SizedBox(height: 50)
      ]),
    );
  }
}
