import 'package:final_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
        SizedBox(height: 16),
        Text("Is there a missing tag?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge),
        Image.asset('assets/missing.PNG'),
        Text("Is there a damaged tag?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge),
        Image.asset('assets/dam.PNG'),
        Text("Click the button below to report any concerns",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text("Report"),
          onPressed: () {
            _launchURL('https://forms.gle/QnkWZRu1437LN3RYA');
          },
        ),
        SizedBox(height: 16)
      ]),
    );
  }
}
