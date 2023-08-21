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
              onPrimary: prime, // selected text color
              onSurface: second, // default text color
              primary: orange // circle color
              ),
          dialogBackgroundColor: Colors.black54,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Quicksand'),
                  primary: Colors.amber, // color of button's letters
                  backgroundColor: Colors.black54, // Background color
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
