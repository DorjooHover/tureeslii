import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/controllers/notification_controller.dart';
import 'package:tureeslii/pages/menu/menu_view.dart';
import 'package:tureeslii/pages/pages.dart';
import 'package:tureeslii/shared/index.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

List<Widget> views = [
  const LocationView(),
  const BookmarkView(),
  const NotificationView(),
  const OrderView(),
  const MenuView(),
];

class _MainViewState extends State<MainView> {
  int currentIndex = 1;
  final notificationController = Get.put(NotificationController());
  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return MainViewWidget(
      onRefresh: () async {
        if (currentIndex == 1) {
          await controller.getSavedPost();
        }

        if (currentIndex == 2 && controller.user != null) {
          await notificationController.getNotification();
        }
        if (currentIndex == 3 && controller.user != null) {
          await controller.getOrders();
        }
      },
      currentIndex: currentIndex,
      child: views[currentIndex],
      changeIndex: (value) {
        setState(() {
          currentIndex = value;
        });
      },
    );
  }
}

class MainViewWidget extends StatelessWidget {
  const MainViewWidget(
      {super.key,
      required this.onRefresh,
      required this.currentIndex,
      required this.child,
      required this.changeIndex});
  final Future<void> Function() onRefresh;
  final int currentIndex;
  final void Function(int) changeIndex;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: prime,
      color: second,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: onRefresh,
      child: ScaffoldMessenger(child: Scaffold(
        appBar: MainAppBar(
          currentIndex: currentIndex,
          height: currentIndex == 4 ? 246 : 63,
          bgColor: currentIndex != 4 ? Colors.white : bgGray,
          statusBarColor: currentIndex != 4 ? Colors.white : bgGray,
        ),
        body: child,
        bottomNavigationBar: MainNavigationBar(
            currentIndex: currentIndex, changeIndex: changeIndex),
      ),)
    );
  }
}
