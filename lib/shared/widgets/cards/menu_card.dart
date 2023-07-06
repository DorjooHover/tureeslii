import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:landlord/shared/constants/colors.dart';

class MenuCard extends StatelessWidget {
  const MenuCard(
      {super.key, required this.icon, required this.text, required this.child});
  final String icon;
  final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
