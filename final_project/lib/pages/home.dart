import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;    // new
import 'package:flutter/material.dart';           // new
import 'package:provider/provider.dart';          // new

import '../app_state.dart';                          // new
import '../widgets/authentication.dart';                 // new
import '../widgets/widgets.dart';

import "/pages/leaderboard.dart";
import "/pages/profile.dart";
import "/pages/report.dart";
import "/pages/about.dart";

import "/widgets/app_overlay.dart";


class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // will need eventually  

  @override
  Widget build(BuildContext context) {
    return AppOverlay("Hendrix Arboretum",1);
  }
}

  
