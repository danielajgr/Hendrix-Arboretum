// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}

class PopupAndSound extends StatefulWidget {
  final bool show;

  const PopupAndSound({required this.show, super.key});

  @override
  _PopupAndSoundState createState() => _PopupAndSoundState();
}

class _PopupAndSoundState extends State<PopupAndSound> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    _playSound();
    _triggerPopup();
  }
  // how to sound: https://stackoverflow.com/questions/56377942/how-to-play-sound-on-button-press

  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/ding.mp3'));
  }
  // https://stackoverflow.com/questions/53615666/how-can-i-make-alertdialog-disappear-automatically-after-few-seconds-in-flutter
  void _triggerPopup() {
    setState(() {
      _showPopup = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showPopup = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showPopup)
          Positioned(
            top: 50, 
            left: 10,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 3,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 118, 206, 124),
                  borderRadius: BorderRadius.circular(5),
                  
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tree Found!",
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    ],
                ),
              ),
            ),
          ),
      ],
    );
  }  
}


