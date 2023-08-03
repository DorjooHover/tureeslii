import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/values.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar(
      {super.key, required this.changeIndex, required this.currentIndex});
  final void Function(int value) changeIndex;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    // return Obx(() => NavigationBar(
    //     selectedIndex: currentIndex,
    //     onDestinationSelected: (value) => changeIndex(value),
    //     destinations: navbar.map((e) {
    //       NavigationDestination body;
    //       body = NavigationDestination(
    //         icon: SvgPicture.asset(
    //           e['icon']!,
    //         ),
    //         selectedIcon: SvgPicture.asset(e['activeIcon']!),
    //         label: e['label']!,
    //       );
    //       // }

    //       return body;
    //     }).toList()));

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: changeIndex,
      selectedItemColor: currentIndex == 1 ? prime : Colors.white,
      unselectedItemColor: navGray,
      backgroundColor: currentIndex == 1 ? Colors.white : Colors.black,
      selectedLabelStyle: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
      type: BottomNavigationBarType.fixed,
      items: navbar.map((e) {
        return BottomNavigationBarItem(
            icon: SvgPicture.asset(e['icon']!),
            activeIcon: SvgPicture.asset(e['activeIcon']!),
            label: e['label']!);
      }).toList(),
    );
    // return NavigationBar(
    //     selectedIndex: currentIndex,

    //     onDestinationSelected: (value) => changeIndex(value),
    //     destinations: navbar.map((e) {
    //       NavigationDestination body;
    //       body = NavigationDestination(
    //         icon: SvgPicture.asset(
    //           e['icon']!,
    //         ),
    //         selectedIcon: SvgPicture.asset(e['activeIcon']!),
    //         label: e['label']!,
    //       );
    //       // }

    //       return body;
    //     }).toList());
  }
}
