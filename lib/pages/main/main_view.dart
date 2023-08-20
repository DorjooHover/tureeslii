import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/pages/menu/menu_view.dart';
import 'package:landlord/pages/pages.dart';
import 'package:landlord/shared/index.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> mainKey = GlobalKey<ScaffoldState>();
  // late Animation<double> animation;
  // late AnimationController animationController;
  List<Widget> views = [
    const ListingView(),
    const BookmarkView(),
    const NotificationView(),
    const OrderView(),
    const MenuView(),
  ];
  int currentIndex = 0;
  bool isDrawer = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) =>
          controller.obx(onLoading: const SplashView(), onError: (error) {
        return Stack(
          children: [
            const SplashView(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  borderOnForeground: true,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Check your internet connection and try again",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => ElevatedButton(
                              onPressed: controller.isLoading.value == true
                                  ? null
                                  : () => controller.setupApp(),
                              child: const Text("Try again"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }, (user) {
        return Scaffold(
          key: mainKey,
          appBar: MainAppBar(
            isDrawer: isDrawer,
            currentIndex: currentIndex,
            bgColor: bgGray,
            statusBarColor: bgGray,
          ),
          body: views[currentIndex],
          onEndDrawerChanged: (isOpened) {
            setState(() {
              isDrawer = isOpened;
            });
          },
          endDrawer: MainDrawer(
              onTap: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              cancel: () {
                mainKey.currentState!.closeEndDrawer();
              },
              selectedIndex: currentIndex),
        );
      }),
    );
  }
}
