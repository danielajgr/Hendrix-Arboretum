import 'package:final_project/app_state.dart';
import 'package:final_project/objects/tree_object.dart';
import 'package:final_project/pages/tree_info.dart';
import 'package:final_project/widgets/widgets.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/authentication.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return AppBarWrapper(
      title: "Profile",
      // https://docs.flutter.dev/cookbook/design/themes
      body: Theme(
        // NOTE(LeitMoth):
        // This theme modification is necessary to prevent the
        // "Send Verification Email" button from overflowing the view.
        // I can't modify ProfileScreen but the I can modify
        // the part of the theme that made to button too large:
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                labelLarge: const TextStyle(
                  // Used for dropdown menu text and search bar labels.
                  // And, importantly, the "Send Verification Email" button
                  // This also affects the sign out and delete account buttons,
                  // but there is not much I can do about that.
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Museo',
                  // Doesn't overflow, and gives a little wiggle room for
                  // skinnier phones. Update if you want, but update with care.
                  fontSize: 18,
                ),
              ),
        ),
        child: ProfileScreen(
          avatarSize: 0,
          providers: const [],
          actions: [
            SignedOutAction((context) {
              context.pushReplacement('/');
            }),
          ],
          children: [
            const Padding(padding: EdgeInsets.all(5)),
            Container(
              padding: const EdgeInsets.all(1),
              child: const TextAndIcon(Icons.forest, "Your Liked Trees", 30),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => ListView(
                  padding: EdgeInsets.all(0.8),
                  shrinkWrap: true,
                  children: appState.getAll().map((item) {
                    return ListTile(
                      shape: const Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 134, 72, 20), width: 1),
                      ),
                      title: Text("Tree #" + item.treeid.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite),
                        color: appState.isFavorite(item.treeid)
                            ? Color.fromARGB(255, 255, 0, 0)
                            : Color(0xff9A9A9A),
                        onPressed: () async {
                          if (!appState.loggedIn) {
                            context.push('/sign-in');
                          } else {
                            if (appState.isFavorite(item.treeid)) {
                              setState(() {
                                appState.removeTree(item.treeid);
                              });
                            } else {
                              setState(() {
                                appState.addTree(item.treeid);
                              });
                            }
                          }
                        },
                      ),
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TreeInfo(treeid: item.treeid),
                          ),
                        );
                      },
                    );
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
