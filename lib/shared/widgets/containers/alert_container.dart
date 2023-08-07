import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';

class AlertContainer extends StatelessWidget {
  const AlertContainer(
      {super.key,
      this.horizontal = 20,
      this.padding = const EdgeInsets.symmetric(horizontal: 20),
      required this.child});
  final List<Widget> child;
  final EdgeInsets padding;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: padding,
      
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            space50,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[...child],
              ),
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
