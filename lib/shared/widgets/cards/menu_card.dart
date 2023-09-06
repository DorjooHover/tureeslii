import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class MenuCard extends StatelessWidget {
  const MenuCard(
      {super.key,
      required this.icon,
      required this.text,
      required this.child,
      this.onTap});
  final String icon;
  final String text;
  final Widget child;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        minLeadingWidth: 11,
        leading: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: child,
        shape: Border(bottom: BorderSide(color: line, width: 1)),
      ),
    );
  }
}
