import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class Social extends StatelessWidget {
  const Social(
      {super.key, this.color = black, required this.icon, required this.text});
  final Widget icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
              ),
        ),
        space24
      ],
    );
  }
}
