import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class AlertContainer extends StatelessWidget {
  const AlertContainer({super.key, required this.child});
  final List<Widget> child;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
