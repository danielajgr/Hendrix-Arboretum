// Copyright 2020 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//    * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//    * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.`

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
                    Text("Tree Found!",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TextAndIcon extends StatelessWidget {
  const TextAndIcon(this.icon, this.detail, this.size, {super.key});
  final IconData icon;
  final String detail;
  final double size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children: [
            Text(
              detail,
              style: TextStyle(fontSize: size),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            ),
            Icon(
              icon,
              color: const Color.fromARGB(255, 11, 103, 14),
              size: 25,
            ),
            const SizedBox(width: 8)
          ],
        ),
      );
}
