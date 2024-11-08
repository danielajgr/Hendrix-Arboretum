// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          IconButton(
              icon: Icon(Icons.account_circle_rounded),
              iconSize: 40,
              onPressed: () {
                !loggedIn ? context.push('/sign-in') : context.push('/profile');
              },
             ),
        
       
      ],
    );
  }
}