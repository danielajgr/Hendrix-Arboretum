import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class About extends StatelessWidget {
  const About({required super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('assets/vines.png'),
            Container(
              child: Text("Hendrix Arboretum",
                  style: Theme.of(context).textTheme.displayLarge),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
                flex: 2,
                child: Column(children: [
                  Text("The Hendrix College Campus Arboretum",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Consistent with its community orientation and the educational goals of Hendrix College, the development of the campus arboretum was intended to provide an educational center for not only Hendrix College, but for the other colleges, public schools, and the general public in the Central Arkansas area, as well as for other visitors to the college.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ])),
          ],
        ),
        Image.asset('assets/vines2.png'),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              'assets/tag.png',
              fit: BoxFit.contain,
              height: 400.0,
            ),
            Positioned(
              top: 150,
              child: ArcText(
                radius: 150,
                text: 'Locate Tag!',
                textStyle: Theme.of(context).textTheme.displayLarge,
                startAngle: -pi / 2.3,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Each tree in the arboretum can be identified with a numbered circular metallic tag, found on the south side of the tree. Enter the ID number in the search field to learn more information about the tree.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          'assets/hendrix_logo.png',
          fit: BoxFit.contain,
          height: 150.0,
        )
      ],
    );
  }
}
