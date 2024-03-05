import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/constants/assets.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';

const double kToolbarHeight = 63.0;

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.back = false,
      this.statusBarColor = Colors.white,
      this.logo = true,
      this.currentIndex,
      this.height = 63,
      this.child,
      this.actions,
      this.center,
      this.menu = true,
      this.isDrawer = false,
      this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.bgColor = Colors.white});
  final Color statusBarColor;
  final Color bgColor;
  final bool back;
  final double height;
  final bool logo;
  final bool menu;
  final int? currentIndex;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? child;
  final bool isDrawer;
  final List<Widget>? actions;
  final Widget? center;
  final Function()? onPressed;
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: isDrawer ? bgGray : statusBarColor, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: const SizedBox(),
      actions: actions ??
          [
            if (menu)
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu_sharp),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
          ],
      titleSpacing: 0,
      leadingWidth: 0,
      toolbarHeight: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: currentIndex == 4
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
            : BorderRadius.zero,
      ),
      backgroundColor: bgColor,
      surfaceTintColor: bgColor,
      title: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: currentIndex != 4
            ? Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (back)
                    ElevatedButton(
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
                      onPressed: onPressed ?? () => Navigator.pop(context),
                    ),
                  logo
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.main);
                          },
                          child: Image.asset(
                            imageLogo,
                            height: 22,
                          ),
                        )
                      : center ?? const SizedBox(),
                  child ?? const SizedBox(),
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

class MyAdsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAdsAppBar(
      {super.key,
      this.back = false,
      this.statusBarColor = Colors.white,
      this.logo = true,
      this.currentIndex,
      this.height = 63,
      this.child,
      this.actions,
      this.center,
      this.isDrawer = false,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.bottom,
      this.title,
      this.bgColor = Colors.white});
  final Color statusBarColor;
  final Color bgColor;
  final bool back;
  final double height;
  final bool logo;
  final int? currentIndex;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? child;
  final bool isDrawer;
  final List<Widget>? actions;
  final Widget? center;
  final PreferredSize? bottom;
  final Widget? title;
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: isDrawer ? bgGray : statusBarColor, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: const SizedBox(),
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_sharp),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
      bottom: bottom,
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
      title: title ??
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: origin),
            child: currentIndex != 4
                ? Row(
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      if (back)
                        ElevatedButton(
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
                        ),
                      logo
                          ? GestureDetector(
                              onTap: () {
                                print('asdf');
                                Get.toNamed(Routes.main);
                              },
                              child: Image.asset(
                                imageLogo,
                                height: 22,
                              ),
                            )
                          : center ?? const SizedBox(),
                      child ?? const SizedBox(),
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
