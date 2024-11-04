import 'package:flutter/material.dart';
import "pages/home.dart";
import "pages/leaderboard.dart";
import "pages/profile.dart";


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "Home",
      routes: {
        "Home": (context) => Home(),
        "Leaderboard": (context) => Leaderboard(topTrees: const [],) // Change later
        // "Profile": (context) => Profile(user: _ )
      }
    );
  }
}
