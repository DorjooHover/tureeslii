import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog(
      {super.key,
      required this.icon,
      required this.description,
      required this.title});
  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(20),
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              icon,
              width: 36,
              height: 36,
            ),
          ),
          space24,
          Text(
            title,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(color: black),
          ),
          space8,
          Text(
            description,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(color: gray1),
          ),
          space8
        ],
      ),
    );
  }
}
