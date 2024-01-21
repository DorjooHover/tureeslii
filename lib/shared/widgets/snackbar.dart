import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/enums.dart';
import 'package:landlord/shared/constants/spacing.dart';
import 'package:landlord/shared/index.dart';

class CustomSnackbar {
  final SnackbarType type;
  final String text;

  const CustomSnackbar({
    required this.text,
    required this.type,
  });

  static show(
    BuildContext context,
    String text,
    SnackbarType type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        duration: const Duration(milliseconds: 1500),
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: small),
        content: Align(
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                snackbarIcon(type),
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
        ),
        // dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(right: 20, left: 20),
        backgroundColor: snackbarColor(type),
        dismissDirection: DismissDirection.endToStart,
        behavior: SnackBarBehavior.floating,
        ));
  }
}

// class CustomSnackbar {
// mainSnackbar(
//   BuildContext context,
//   String text,
//   SnackbarType type,
// ) {
//   Color color = green;
//   IconData icon = Icons.check;
//   bool keyboard = WidgetsBinding.instance.window.viewInsets.bottom > 0;
//   switch (type) {
//     case SnackbarType.error:
//       color = red;
//       icon = Icons.error;
//       break;
//     case SnackbarType.warning:
//       color = warning;
//       icon = Icons.info;
//       break;
//     default:
//       color = green;
//       icon = Icons.check;
//   }
//   final snackbar = SnackBar(
//       duration: const Duration(milliseconds: 1500),
//       padding:
//           const EdgeInsets.symmetric(horizontal: origin, vertical: small),
//       content: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Icon(
//             icon,
//             color: Colors.white,
//           ),
//           space16,
//           Flexible(
//               child: Text(
//             text,
//             maxLines: 3,
//           ))
//         ],
//       ),
//       // dismissDirection: DismissDirection.up,
//       margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).size.height -
//               (keyboard ? MediaQuery.of(context).viewInsets.bottom : 0) -
//               100,
//           right: 20,
//           left: 20),
//       backgroundColor: color,
//       behavior: SnackBarBehavior.floating);
//   ScaffoldMessenger.of(context).showSnackBar(snackbar);
// }
// }
