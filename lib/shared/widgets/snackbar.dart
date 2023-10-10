import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/enums.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class CustomSnackbar {
  mainSnackbar(
    BuildContext context,
    String text,
    SnackBarTypes type,
  ) {
    Color color = green;
    IconData icon = Icons.check;
    bool keyboard = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    switch (type) {
      case SnackBarTypes.error:
        color = red;
        icon = Icons.error;
        break;
      case SnackBarTypes.warning:
        color = warning;
        icon = Icons.info;
        break;
      default:
        color = green;
        icon = Icons.check;
    }
     Get.snackbar(text, '', animationDuration: const Duration(milliseconds: 1500),
     messageText: Container(),
     padding:const EdgeInsets.symmetric(horizontal: origin, vertical: small), icon: Icon(
              icon,
              color: Colors.white,
            ), margin:  EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height -
                (keyboard ? MediaQuery.of(context).viewInsets.bottom : 0) -
                100,
            right: 20,
            left: 20), backgroundColor: color);

  }
}
