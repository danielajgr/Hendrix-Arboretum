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
import 'package:final_project/api/specialty.dart';
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




class SearchDropdown extends StatefulWidget {
  final List<Specialty> specialtyList;
  final Specialty? selectedSpecialty;
  final Function(Specialty?) onSpecialtySelected;
  final Function(String) onSearch;

  const SearchDropdown({
    required this.specialtyList,
    this.selectedSpecialty,
    required this.onSpecialtySelected,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  _SearchDropdownState createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4.0,
            color: const Color.fromARGB(255, 188, 159, 128),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.specialtyList.map((specialty) {
                return ListTile(
                  title: Text(
                    specialty.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  onTap: () {
                    widget.onSpecialtySelected(specialty);
                    _controller.text = specialty.title;
                    _closeDropdown();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Select or Search",
          hintStyle: Theme.of(context).textTheme.labelLarge,
          suffixIcon: GestureDetector(
            onTap: _toggleDropdown,
            child: Icon(
              _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
          fillColor: const Color.fromARGB(255, 199, 96, 22),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        onSubmitted: (query) {
          widget.onSearch(query);
        },
      ),
    );
  }
}
