import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  const Switcher(
      {super.key, this.title, required this.value, required this.onChange});
  final bool value;
  final Function(bool) onChange;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(title: title, value: value, onChanged: onChange);
  }
}
