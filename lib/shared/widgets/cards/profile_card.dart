import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/shared/constants/assets.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.icon,
      required this.value,
      required this.title,
      this.edit,
      this.onPressed,
      this.verified});
  final String title;
  final String value;
  final bool icon;
  final bool? verified;
  final bool? edit;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(color: gray),
            ),
            space10,
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        if (icon)
          verified != null && verified!
              ? IconButton(
                  onPressed: onPressed, icon: SvgPicture.asset(iconVerified))
              : IconButton(
                  onPressed: onPressed,
                  icon: SvgPicture.asset(iconNotVerified)),
        if (edit != null)
          IconButton(onPressed: onPressed, icon: SvgPicture.asset(iconEdit))
      ],
    );
  }
}
