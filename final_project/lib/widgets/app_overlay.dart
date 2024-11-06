import 'package:flutter/material.dart';

import "/pages/about.dart";
import "/pages/home.dart";
import "/pages/leaderboard.dart";
import "/pages/profile.dart";
import "/pages/report.dart";




class AppOverlay extends StatefulWidget {
  AppOverlay(
    this.pageTitle,
    this.pageIndex
  );

  final String pageTitle;
  int pageIndex;

  @override 
  _AppOverlayState createState() => _AppOverlayState();
}

class _AppOverlayState extends State<AppOverlay> {


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
      title: Text(widget.pageTitle),
      actions: [
        IconButton(
          icon: Icon(Icons.report),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Report(),
              ),
            );
          },
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.account_circle_rounded),
        iconSize: 40,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Report(),
            ),
          );
        },
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
        ],
        currentIndex: widget.pageIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) async {
    setState(() {
    });
  if (index != widget.pageIndex) {
    switch (index) {
      case 0:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Leaderboard(
              topTrees: [],
            ),
          ),
        );
        break;
      case 1: 
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Home(
            ),
          ),
        );
        break;
      case 2:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => About(
            ),
          ),
        );
        break;
      default:
        // error
        break;
      }
    }
  }
   
}
