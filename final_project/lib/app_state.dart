// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/api/tree.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  List<int> likedTrees = [];
  List<int> allLikedTrees = [];
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    loadAllLikedTrees();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        loadLikedTrees();
      } else {
        _loggedIn = false;
        likedTrees.clear();
      }
      notifyListeners();
    }); 
    
  }

  Future<void> loadAllLikedTrees() async {
    FirebaseFirestore.instance.collection('favoriteTrees').snapshots().listen((snapshot) async {  
        List<int> alt = [];

        for (var d in snapshot.docs) {
          final likesDoc = await FirebaseFirestore.instance.collection('favoriteTrees').doc(d.id).get();
          if(likesDoc.exists) {
            final toAdd = List<int>.from(likesDoc.data()?['likes'] ?? []);
            for(var add in toAdd){
              alt.add(add);
            }
          }
        }
        allLikedTrees = alt;

      });
   
    
  }

  Future<void> loadLikedTrees() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('favoriteTrees')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        likedTrees = List<int>.from(doc.data()?['likes'] ?? []);
      } else {
        likedTrees = [];
      }
      notifyListeners();
    }
  }
  
  

  void addTree(int id) async {
    if (!likedTrees.contains(id)) {
      likedTrees.add(id);
      await updateLikedTreesInFirestore();
      notifyListeners();
    }
  }



  void removeTree(int id) async {
    int i = 0;
    int remove = 0;
    for (var t in likedTrees){
      if(t == id){
        remove = i;
      }
      i++;
    }

    likedTrees.removeAt(remove);

    await updateLikedTreesInFirestore();
    notifyListeners();  
    }



  Future<void> updateLikedTreesInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('favoriteTrees')
          .doc(user.uid)
          .set({
        'name': user.displayName,
        'likes': likedTrees,
      }, SetOptions(merge: true));
    }
  }

  bool isFavorite(int id){
    return likedTrees.contains(id);
  }

  List getAll(){
    return likedTrees;
  }

  List getAllTrees(){
    return allLikedTrees;
  }
}