import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/pages.dart';
import 'package:landlord/shared/index.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}


class _MyOrdersViewState extends State<MyOrdersView> {
bool isDrawer = false;
  String selectedBank = bankValues[0];
  final GlobalKey<ScaffoldState> myOrdersKey = GlobalKey<ScaffoldState>();
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
      child: Scaffold(
        key: myOrdersKey,
        backgroundColor: Colors.white,
        appBar: MyAdsAppBar(
          height: MediaQuery.of(context).padding.top + 170,
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
                    Image.asset(
                      imageLogo,
                      height: 22,
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
                child:
                    Text(
                      order,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: black, fontWeight: FontWeight.w600),
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
              width: double.infinity,
              color: Colors.white,
              child: TabBar(
                
                
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: prime,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                labelColor: black,
                unselectedLabelColor: black,
                tabs: [
                  Tab(height: 30, text: expected),
                  Tab(height: 30, text: agreed),
                  Tab(height: 30, text: history),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ExpectedView(
    
            ),
            AgreedView(
           
            ),
            HistoryView(),
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
              myOrdersKey.currentState!.closeEndDrawer();
            },
            selectedIndex: 0),
      ),
    );
  }
}
