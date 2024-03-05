import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';

class DatePickerThemeWidget extends StatelessWidget {
  const DatePickerThemeWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
              onPrimary: Colors.white, // selected text color
              onSurface: Colors.white, // default text color
              primary: prime, // circle color

              background: prime),
          dialogBackgroundColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Quicksand'),
                  // primary: Colors.amber, // color of button's letters
                  backgroundColor: prime,
                  iconColor: Colors.white, // Background color
                  shadowColor: Colors.white,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50))))),
      child: child,
    );
  }
}
