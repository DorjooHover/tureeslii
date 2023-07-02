import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tureeslii/shared/constants/assets.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

const double kToolbarHeight = 63.0;

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.back = false,
      this.statusBarColor = Colors.white,
      this.logo = true,
      this.currentIndex,
      this.height = 63,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.bgColor = Colors.white});
  final Color statusBarColor;
  final Color bgColor;
  final bool back;
  final double height;
  final bool logo;
  final int? currentIndex;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Size get preferredSize => Size.fromHeight(height);

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
      toolbarHeight: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: currentIndex == 4
            ? BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
            : BorderRadius.zero,
      ),
      backgroundColor: bgColor,
      title: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: currentIndex != 4
            ? Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  back
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(small),
                              backgroundColor: Colors.white,
                              shape: const CircleBorder()),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: gray,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : const SizedBox(),
                  logo
                      ? Image.asset(
                          imageLogo,
                          height: 22,
                        )
                      : const SizedBox(),
                  const SizedBox()
                ],
              )
            : Stack(
                children: [
                  Column(
                    children: <Widget>[
                      space32,
                      Image.asset(
                        imageLogo,
                        width: 200,
                      ),
                      Image.asset(
                        imageAppBarText,
                        width: double.infinity,
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    child: back
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: const EdgeInsets.all(small),
                                backgroundColor: Colors.white,
                                shape: const CircleBorder()),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: gray,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : const SizedBox(),
                  )
                ],
              ),
      ),
    );
  }
}
