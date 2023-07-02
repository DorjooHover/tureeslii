import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class MainSpacer extends StatelessWidget {
  const MainSpacer({super.key, required this.text});
  final String text;
  final Color color = spacerGray;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          height: 1,
          color: color,
        )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(color: gray1),
            )),
        Expanded(
            child: Container(
          height: 1,
          color: color,
        ))
      ],
    );
  }
}
