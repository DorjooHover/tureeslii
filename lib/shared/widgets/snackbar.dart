import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';

class CustomSnackbar {
  mainSnackbar(
    BuildContext context,
    String text,
    String type,
  ) {
    Color color = green;
    IconData icon = Icons.check;
    bool keyboard = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    switch (type) {
      case 'error':
        color = red;
        icon = Icons.error;
        break;
      case 'warning':
        color = warning;
        icon = Icons.info;
        break;
      default:
        color = green;
        icon = Icons.check;
    }
    final snackbar = SnackBar(
        duration: const Duration(milliseconds: 1500),
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: small),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            space16,
            Flexible(
                child: Text(
              text,
              maxLines: 3,
            ))
          ],
        ),
        // dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height -
                (keyboard ? MediaQuery.of(context).viewInsets.bottom : 0) -
                100,
            right: 20,
            left: 20),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
