import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(20)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 0))
        ],
      ),
      child: child,
    );
  }
}
