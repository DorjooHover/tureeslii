import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tureeslii/shared/constants/assets.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

const double kToolbarMenuHeight = 246.0;

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBar(
      {super.key,
      this.statusBarColor = Colors.white,
      this.currentIndex,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.bgColor = Colors.white});
  final Color statusBarColor;
  final Color bgColor;
  
  final double? currentIndex;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Size get preferredSize =>  Size.fromHeight(currentIndex ?? kToolbarMenuHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: const SizedBox(),
      titleSpacing: 0,
      leadingWidth: 0,
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      backgroundColor: bgColor,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Image.asset(
              imageLogo,
              height: 22,
            ),
            Image.asset(
              imageAppBarText,
              height: 22,
            )
          ],
        ),
      ),
    );
  }
}
