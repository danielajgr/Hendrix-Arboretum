// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";

import 'package:final_project/api/tree.dart';
import 'package:final_project/objects/tree_object.dart';
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
    FirebaseFirestore.instance
        .collection('favoriteTrees')
        .snapshots()
        .listen((snapshot) async {
      List<int> alt = [];

      for (var d in snapshot.docs) {
        final likesDoc = await FirebaseFirestore.instance
            .collection('favoriteTrees')
            .doc(d.id)
            .get();
        if (likesDoc.exists) {
          final toAdd = List<int>.from(likesDoc.data()?['likes'] ?? []);
          for (var add in toAdd) {
            alt.add(add);
          }
        }
      }
      allLikedTrees = alt;
      notifyListeners();
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
    for (var t in likedTrees) {
      if (t == id) {
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

  bool isFavorite(int id) {
    return likedTrees.contains(id);
  }

  List<TreeObject> getAll() {
    return getTrees(likedTrees);
  }

  bool inList(TreeObject tree, List list) {
    for (var item in list) {
      if (item.treeid == tree.treeid) {
        return true;
      } else {
        if (list.isEmpty) {
          return false;
        }
      }
    }
    return false;
  }

  int findDuplicate(TreeObject tr, List<TreeObject> listTr) {
    int index = 0;
    for (var t in listTr) {
      if (t.treeid == tr.treeid) {
        return index;
      } else {
        index++;
      }
    }
    return index;
  }

  List<TreeObject> getTrees(List ids) {
    List<TreeObject> ts = [];
    for (var id in ids) {
      TreeObject t = TreeObject(treeid: id);
      if (inList(t, ts) == false) {
        t.add_like();
        ts.add(t);
      } else {
        int i = findDuplicate(t, ts);
        ts[i].add_like();
      }
    }
    return ts;
  }

  List<TreeObject> getTopTrees() {
    PriorityQueue<TreeObject> treeQueue = PriorityQueue();
    List<TreeObject> topTenTrees = [TreeObject(treeid: 0000)];
    List<TreeObject> trees = getTrees(allLikedTrees);
    if (topTenTrees.length == 1) {
      treeQueue.addAll(trees);
      for (int i = 0; i < 10 && treeQueue.isNotEmpty; i++) {
        topTenTrees.add(treeQueue.removeFirst());
      }
    }
    return topTenTrees;
  }
}
