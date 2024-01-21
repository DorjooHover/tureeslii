import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/enums.dart';

Color snackbarColor (SnackbarType type) {
   Color color = green;

  switch (type) {
    case SnackbarType.error:
      color = red;
      
      break;
    case SnackbarType.warning:
      color = warning;
  
      break;
    default:
      color = green;

  }
  return color;
} 
IconData snackbarIcon (SnackbarType type) {
 
  IconData icon = Icons.check;
  switch (type) {
    case SnackbarType.error:
   
      icon = Icons.error;
      break;
    case SnackbarType.warning:

      icon = Icons.info;
      break;
    default:
  
      icon = Icons.check;
  }
  return icon;
} 