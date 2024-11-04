import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens (optional)
    if (index == 1) {
      Navigator.pushNamed(context, "Leaderboard");
    } else if (index == 2) {
      Navigator.pushNamed(context, "Profile");
    }
    // Add additional logic for other tabs if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hendrix Arboretum")),
      body: Text("cool map here"),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}