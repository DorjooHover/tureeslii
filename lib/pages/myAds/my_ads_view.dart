import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/pages.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class MyAdsView extends StatefulWidget {
  const MyAdsView({super.key});

  @override
  State<MyAdsView> createState() => _MyAdsViewState();
}

bool isDrawer = false;

class _MyAdsViewState extends State<MyAdsView> {
  String selectedBank = bankValues[0];
  final GlobalKey<ScaffoldState> myAdsKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(MainController());
  final publishedPost = <Post>[];
  final unpublishedPost = <Post>[];
  @override
  void initState() {
    super.initState();

    controller.getOwnPost(null, []).then((value) => setPosts());
  }

  setPosts() {
    for (var element in controller.ownPost) {
      if (element.status?.toLowerCase() == postStatus[0]) {
        publishedPost.add(element);
      } else {
        unpublishedPost.add(element);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          key: myAdsKey,
          backgroundColor: Colors.white,
          appBar: MyAdsAppBar(
            height: MediaQuery.of(context).padding.top + 220,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: origin, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.main);
                        },
                        child: Image.asset(
                          imageLogo,
                          height: 22,
                        ),
                      ),
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu_sharp),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: origin, vertical: 25),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Миний',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: black, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'оруулсан зар',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [Container()],
            bgColor: bgGray,
            statusBarColor: bgGray,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: prime,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                  labelColor: black,
                  unselectedLabelColor: black,
                  tabs: const [
                    Tab(height: 30, text: published),
                    Tab(height: 30, text: entered),
                    Tab(height: 30, text: notEnough),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              PublishedView(),
              EnteredView(),
              NotEnoughView(),
            ],
          ),
          onEndDrawerChanged: (isOpened) {
            setState(() {
              isDrawer = isOpened;
            });
          },
          endDrawer: MainDrawer(
              onTap: (int index) {},
              cancel: () {
                myAdsKey.currentState!.closeEndDrawer();
              },
              selectedIndex: 0),
        ),
      ),
    );
  }
}
